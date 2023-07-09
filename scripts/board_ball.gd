extends Node2D


func _ready():
	pass

func place_number(number):
	$board_ball_number.text = str(number)
