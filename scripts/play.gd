extends Node2D


func _ready():
	pass

# this signal allow change of scenes from the start screen to the screen of the
# game
func _on_play_button_button_down():
	get_tree().change_scene("res://scenes/screen.tscn")
