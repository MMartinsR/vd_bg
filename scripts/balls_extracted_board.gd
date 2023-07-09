extends Node2D

var ball_instance
var initial_position = Vector2(100, 100)
var extracted_balls_board = []

func _ready():
	pass

func spawn_board_numbers(numbers, x_start, y_start, offset):
	var y = 0
	#for x in numbers.size():
		#ball_instance = Utils.create_instance(numbers[x]) # criando a bola
		#ball_instance.place_number(numbers[x])
		#add_child(ball_instance)
		# position the card number 
		#ball_instance.position = Utils.array_to_pixel_convertion(x_start, y_start, x, y, offset)
	pass
