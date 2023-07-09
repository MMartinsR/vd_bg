extends Node2D

# reference to our card
const PRE_CARD = preload("res://scenes/card.tscn")
const PRE_BOARD = preload("res://scenes/balls_extracted_board.tscn")

# Balls extraction -> numbers generation
export (int) var start_from
export (int) var end_at
export (int) var extraction_balls_quantity

# Card start position
export (int) var x_start
export (int) var y_start
export (int) var offset

# Balls for extraction
var extraction_balls = []

# Extracted balls
export (int) var extraction_balls_timer
export var inicial_position = Vector2.ZERO
var count = 0

func _ready():
	# generate numbers for the balls
	spawn_board()
	spawn_card()
	

func _process(delta):
	pass

func spawn_ball():
	if  count < extraction_balls.size():
		var number = extraction_balls[count]
		var ball_instance = Utils.create_instance(number)
		ball_instance.position = inicial_position
		# callback of the function spawn_ball
		ball_instance.receive_callback(funcref(self, "spawn_ball"))
		ball_instance.place_number(number)
		add_child(ball_instance)
		count += 1

# this function will generate the numbers for the balls that wil be extracted
func generate_ball_numbers():
	extraction_balls = Utils.generate_random_numbers(start_from, end_at, extraction_balls_quantity)
	print(extraction_balls)

func spawn_board():
	generate_ball_numbers()
	var board_instance = PRE_BOARD.instance()
	board_instance.spawn_board_numbers(extraction_balls, 100, 100, offset)
	add_child(board_instance)
	spawn_ball()
	pass

func spawn_card():
	var card_instance = PRE_CARD.instance()
	card_instance.spawn_numbers(x_start, y_start, offset)
	add_child(card_instance)
