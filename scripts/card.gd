extends Node2D

# Reference to our number scene
const PRE_NUMBER = preload("res://scenes/number.tscn")

# Card numbers generation 
export (int) var start_from
export (int) var end_at
# Array to receive the numbers of the card
var card_array = []
var generate_card_numbers = []

func _ready():
	pass

func _process(delta):
	pass

# spawn card numbers
func spawn_numbers(x_start, y_start, column, line, offset, numbers):

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


func get_card_number(position):
	var nodes = get_children()
	var node = nodes[position + 1]
	node.get_node("number_label").add_color_override("font_color", Color("11752c"))
