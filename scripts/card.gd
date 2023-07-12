extends Node2D

# Reference to our number scene
const PRE_NUMBER = preload("res://scenes/number.tscn")

var number_count = 0

func _ready():
	pass

func _process(delta):
	pass

# spawn card numbers
func spawn_numbers(x_start, y_start, column, line, offset, numbers):
	number_count = line * column
	for x in line:
		for y in column:
			# pick the number for that position
			var number = numbers[column * x + y]
			# add an instance of our number
			var number_instance = PRE_NUMBER.instance()
			# add the number inside the number object
			number_instance.place_number(number)
			# add to the card as child
			add_child(number_instance)
			# position the card number 
			number_instance.position = Utils.array_to_pixel_convertion(x_start, y_start, x, y, offset)

# this function is responsible change a number color
func change_number_color(position):
	var node = get_number_nodes(position)
	node.get_node("number_label").add_color_override("font_color", Color("11752c"))

# this is a helper function to sort out only number nodes
func get_number_nodes(position):
	var nodes = get_children()
	var not_number_nodes = get_child_count() - number_count
	var node = nodes[not_number_nodes + position]
	return node
