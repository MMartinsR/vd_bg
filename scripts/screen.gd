extends Node2D

# reference to our card
const PRE_CARD = preload("res://scenes/card.tscn")
# reference to our board
const PRE_BOARD = preload("res://scenes/balls_extracted_board.tscn")

# Balls extraction -> numbers generation
# range of numbers to be generated 
export (int) var first_number = 1
export (int) var last_number = 60

# Card size
export (int) var card_column = 5
export (int) var card_line = 3
# Card position
export (int) var x_start = 150
export (int) var y_start = 500
export (int) var offset = 75

# Card numbers
var card_numbers = []

# Board size
export (int) var board_column = 10
export (int) var board_line = 3
# Board position
export (int) var board_x_start = 130
export (int) var board_y_start = 120
export (int) var board_offset = 50

var board_instance
var card_instance
var ball_instance

# Balls for extraction
var drawn_balls = []

# Extracted balls
export var inicial_position = Vector2.ZERO
var count = 0

var isSmall = false
var isPaused = false

# Prizes choices
var prize_bingo = false
export (bool) var prize_column = false
export (bool) var prize_line = false
export (bool) var prize_diagonal = false

func _ready():
	spawn_board()
	spawn_card()
	$prize/prize_label.visible = false
	


# this function is responsible of spawning the drawn balls
func spawn_ball():
	if  count < drawn_balls.size():
		var number = drawn_balls[count]
		ball_instance = Utils.create_ball_instance(number, isSmall)
		ball_instance.position = inicial_position
		# callback of the function show_ball_board
		ball_instance.receive_callback(funcref(self, "show_ball_board"))
		ball_instance.place_number(number, card_numbers.has(drawn_balls[count]))
		add_child(ball_instance)
		count += 1
	else:
		check_prizes()

# this function builds the board
func show_ball_board():
	board_instance.change_ball_visibility(count)
	check_drawn_ball()
	spawn_ball()
	

# this function verifies if the drawn balls match one of the card numbers
func check_drawn_ball():
	if card_numbers.has(drawn_balls[count - 1]):
		var match_index = card_numbers.find(drawn_balls[count - 1])
		card_instance.change_number_color(match_index)

# this function generates the numbers for the balls that will be drawn
func generate_ball_numbers():
	drawn_balls = Utils.generate_random_numbers(first_number, last_number, board_column * board_line)

# this functions generates the card numbers
func generate_card_numbers():
	card_numbers = Utils.generate_random_numbers(first_number, last_number, card_column * card_line)
	card_numbers.sort()

# this function starts the board
func spawn_board():
	generate_ball_numbers()
	board_instance = PRE_BOARD.instance()
	board_instance.spawn_board_numbers(drawn_balls, board_x_start, board_y_start, board_column, board_line, board_offset)
	add_child(board_instance)
	spawn_ball()
	pass

# this function starts the card
func spawn_card():
	generate_card_numbers()
	card_instance = PRE_CARD.instance()
	card_instance.spawn_numbers(x_start, y_start, card_column, card_line, offset, card_numbers)
	add_child(card_instance)

# this functions validates if the player won any prize
func check_prizes():
	var prizes_array = []
	var label_prize
	
	prize_bingo = Utils.check_prizes_bingo(card_numbers, drawn_balls)
	if prize_bingo:
		label_prize = "BINGO!!"
		print_prize(label_prize, 40)
		return
	
	if prize_line:
		var isLines = Utils.check_prizes_line(card_line, card_column, card_numbers, drawn_balls)
		if isLines != card_line:
			var lines_quantity = card_line - isLines
			prizes_array.append(str(lines_quantity) + " LINE(S) ")
			
	if prize_column:
		var isColumns = Utils.check_prizes_column(card_line, card_column, card_numbers, drawn_balls)
		if isColumns != card_column:
			var column_quantity = card_column - isColumns
			prizes_array.append(str(column_quantity) + " COLUMN(S) ")
			
	if prize_diagonal and card_line == card_column:
		var isDiagonals = Utils.check_prizes_diagonal(card_line, card_numbers, drawn_balls)
		if isDiagonals < 2:
			prizes_array.append(str(2 - isDiagonals) + " DIAGONAL(S) ")
	
	if prizes_array.empty():
		label_prize = "NO PRIZES FOR YOU, TRY AGAIN"
		print_prize(label_prize, 30)
	else:
		label_prize = "CONGRATULATIONS!! YOU WON \n" 
		for i in prizes_array.size():
			label_prize += prizes_array[i]
		print_prize(label_prize, 18)

func change_font_size(newSize):
	var font = $prize/prize_label.get("custom_fonts/font")
	font.size = newSize
	$prize/prize_label.add_font_override("custom_fonts/font", font)

func print_prize(text, newSize):
	change_font_size(newSize)
	$prize/prize_label.text = text
	$prize/prize_label.visible = true
	$button/button_control.text = "Play Again"

func _on_button_control_button_down():
	# if the draw is still happening, it should pause the game
	if count < drawn_balls.size():
		ball_instance.pause(isPaused)
		var button_text = "Resume" 
		# if the game is paused, it should resume
		if isPaused:
			button_text = "Pause"
		$button/button_control.text = button_text
		isPaused = !isPaused
	# if the draw is over, it should reset the game
	else:
		play_again()

func play_again():
	get_tree().reload_current_scene()
