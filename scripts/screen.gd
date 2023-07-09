extends Node2D

# reference to our card
const PRE_CARD = preload("res://scenes/card.tscn")
const PRE_BOARD = preload("res://scenes/balls_extracted_board.tscn")

# Balls extraction -> numbers generation
export (int) var start_from
export (int) var end_at
#export (int) var extraction_balls_quantity

# Card position and size
export (int) var column
export (int) var line
export (int) var x_start
export (int) var y_start
export (int) var offset

var card_numbers = []

# Board position
export (int) var board_column
export (int) var board_line
export (int) var board_x_start
export (int) var board_y_start
export (int) var board_offset

var board_instance
var card_instance

# Balls for extraction
var extraction_balls = []

# Extracted balls
export (int) var extraction_balls_timer
export var inicial_position = Vector2.ZERO
var count = 0

var isSmall = false

func _ready():
	# generate numbers for the balls
	spawn_board()
	spawn_card()
	check_prizes()
	

func _process(delta):
	pass

func spawn_ball():
	if  count < extraction_balls.size():
		var number = extraction_balls[count]
		var ball_instance = Utils.create_ball_instance(number, isSmall)
		ball_instance.position = inicial_position
		# callback of the function spawn_ball
		ball_instance.receive_callback(funcref(self, "show_ball_board"))
		ball_instance.place_number(number)
		add_child(ball_instance)
		count += 1
	else:
		check_prizes()

func show_ball_board():
	board_instance.get_ball_child(count)
	change_number_color()
	spawn_ball()

func change_number_color():
	if card_numbers.has(extraction_balls[count - 1]):
		var match_index = card_numbers.find(extraction_balls[count - 1])
		card_instance.get_card_number(match_index)

# this function will generate the numbers for the balls that wil be extracted
func generate_ball_numbers():
	extraction_balls = Utils.generate_random_numbers(start_from, end_at, board_column * board_line)
	print(extraction_balls)

func generate_card_numbers():
	card_numbers = Utils.generate_random_numbers(start_from, end_at, column * line)
	card_numbers.sort()
	

func spawn_board():
	generate_ball_numbers()
	board_instance = PRE_BOARD.instance()
	board_instance.spawn_board_numbers(extraction_balls, board_x_start, board_y_start, board_column, board_line, board_offset)
	add_child(board_instance)
	spawn_ball()
	pass

func spawn_card():
	generate_card_numbers()
	card_instance = PRE_CARD.instance()
	card_instance.spawn_numbers(x_start, y_start, column, line, offset, card_numbers)
	add_child(card_instance)

func check_prizes():
	var isLines = 0
	for x in line:
		for y in column:
			if !extraction_balls.has(card_numbers[column * x + y]):
				isLines += 1
				break
				
	# caso isLines for 0, quer dizer que ele acertou todos os numeros, logo BINGO
	if isLines == 0:
		print("BINGO")
	# caso isLines seja igual ao número de linhas, quer dizer que ele não ganhou nada
	elif isLines == line:
		print("NOTHING")
	# quer dizer que ele acertou x número de linhas
	else:
		var lines_quantity = line - isLines
		print("LINE " + str(lines_quantity))
		
