extends Node2D

var ball_instance
var initial_position = Vector2(100, 100)
var extracted_balls_board = []

var isSmall = true

var ball_extracted_count = 0

func _ready():
	pass

# this function allows the spawn of the drawn numbers
func spawn_board_numbers(numbers, x_start, y_start, width, height, offset):
	ball_extracted_count = width * height
	for x in height:
		for y in width:
			var number = numbers[width * x + y]
			ball_instance = Utils.create_ball_instance(number, isSmall) 
			ball_instance.place_number(number)
			add_child(ball_instance)
			ball_instance.visible = false
			ball_instance.position = Utils.array_to_pixel_convertion(x_start, y_start, x, y, offset)
			

# this function changes the visibility of a specific board ball to true when 
# the animation of a drawn ball ends
func change_ball_visibility(position):
	var node = get_ball_nodes(position)
	node.visible = true

# this is a helper function to sort out only ball nodes
func get_ball_nodes(position):
	var nodes = get_children()
	var not_ball_nodes = get_child_count() - ball_extracted_count - 1
	var node = nodes[not_ball_nodes + position]
	return node
