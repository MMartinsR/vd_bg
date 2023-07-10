extends Control

var isPaused = false setget pause_game

func pause_game(pause):
	isPaused = pause
	get_tree().paused = isPaused
