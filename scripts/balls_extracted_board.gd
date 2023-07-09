extends Node2D

var ball_instance
var initial_position = Vector2(100, 100)
var extracted_balls_board = []

var isSmall = true

func _ready():
	pass

func spawn_board_numbers(numbers, x_start, y_start, width, height, offset):
	for x in height:
		for y in width:
			var number = numbers[width * x + y]
			ball_instance = Utils.create_ball_instance(number, isSmall) # criando a bola
			ball_instance.place_number(number)
			add_child(ball_instance)
			ball_instance.visible = false
			ball_instance.position = Utils.array_to_pixel_convertion(x_start, y_start, x, y, offset)
			

func get_ball_child(position):
	var nodes = get_children()
	var node = nodes[position]
	node.visible = true
