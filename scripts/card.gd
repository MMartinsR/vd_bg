extends Node2D

# Reference to our number scene
const PRE_NUMBER = preload("res://scenes/number.tscn")

# Card size definition
export (int) var width
export (int) var height
# Card start position
#export (int) var x_start
#export (int) var y_start
#export (int) var offset
# Card numbers generation 
export (int) var start_from
export (int) var end_at
# Array to receive the numbers of the card
var card_array = []
var generate_card_numbers = []

func _ready():
	card_array = create2DArray()
	

func _process(delta):
	pass

# this function is used to create the matrix which will receive the numbers of the card
func create2DArray():
	var array = []
	for x in height:
		array.append([]) # adding an array at the end of the existing array
		for y in width:
			array[x].append(null)
	return array

# spawn card numbers
func spawn_numbers(x_start, y_start, offset):
	generate_card_numbers = Utils.generate_random_numbers(start_from, end_at, width * height)
	generate_card_numbers.sort()
	for x in height:
		for y in width:
			# pick the number for that position
			var number = generate_card_numbers[width * x + y]
			# add an instance of our number
			var number_instance = PRE_NUMBER.instance()
			# add the number inside the number object
			number_instance.place_number(number)
			# add to the card as child
			add_child(number_instance)
			# position the card number 
			number_instance.position = Utils.array_to_pixel_convertion(x_start, y_start, x, y, offset)


