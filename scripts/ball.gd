extends Node2D

export (String) var color
export (int) var speed
var callback

func _ready():
	pass

func _process(delta):
	pass

func place_number(number):
	$ball_number.text = str(number)

# this is a helper function that allows a callback of a specified function
func receive_callback(callback):
	self.callback = callback

# calls next ball and remove this one from memory
func _on_animation_ball_animation_finished(anim_name):
	callback.call_func()
	queue_free()
	

