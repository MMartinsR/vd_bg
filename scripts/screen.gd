extends Node2D

# reference to our card
const PRE_CARD = preload("res://scenes/card.tscn")
# reference to our board
const PRE_BOARD = preload("res://scenes/balls_extracted_board.tscn")

# reference to our sounds
onready var audio_success = $"../success_sound"

# Balls extraction -> numbers generation
# range of numbers to be generated 
export (int) var first_number = 1
export (int) var last_number = 60

# Card size
export (int) var column = 5
export (int) var line = 3
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
export (int) var drawn_balls_timer = 3
export var inicial_position = Vector2.ZERO
var count = 0

var isSmall = false
var isPaused = false

func _ready():
	spawn_board()
	spawn_card()
	check_prizes()
	$button/button_control.text = "Pause"
	

func _process(delta):
	pass

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
	print("Drawn balls " + str(drawn_balls))

# this functions generates the card numbers
func generate_card_numbers():
	card_numbers = Utils.generate_random_numbers(first_number, last_number, column * line)
	card_numbers.sort()
	print("Card numbers " + str(card_numbers))
	
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
	card_instance.spawn_numbers(x_start, y_start, column, line, offset, card_numbers)
	add_child(card_instance)

# this functions validates if the player won any prize
func check_prizes():
	var isLines = Utils.check_prizes_line(line, column, card_numbers, drawn_balls)
	var isColumns = Utils.check_prizes_column(line, column, card_numbers, drawn_balls)
	
	# if isLines is zero, it means that the player got all numbers, so its BINGO
	if isLines == 0 and isColumns == 0:
		print("BINGO")
	# if isLines equals the number of lines, that means the player won nothing
	elif isLines == line and isColumns == column:
		print("NOTHING")
	# else, it shows how many lines the player hit
	else:
		if isLines != line:
			var lines_quantity = line - isLines
			print("LINE's Won " + str(lines_quantity))
		if isColumns != column:
			var column_quantity = column - isColumns
			print("COLUMN's Won " + str(column_quantity))
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
