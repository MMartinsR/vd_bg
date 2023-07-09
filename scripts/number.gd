extends Node2D



func _ready():
	pass

func place_number(number):
	$number_label.text = str(number)
