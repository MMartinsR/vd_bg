extends Node2D


func _ready():
	pass


func _on_play_button_button_down():
	get_tree().change_scene("res://scenes/screen.tscn")