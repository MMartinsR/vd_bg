extends Node2D

export (String) var color
onready var animation = $animation_ball

var callback
var isSucessSong = false

func _ready():
	animation.playback_speed = 0.8
	

func place_number(number, isSucessSong):
	$ball_number.text = str(number)
	self.isSucessSong = isSucessSong

# this function load both songs and use just one AudioStreamPlayer to play them
func play_song():
	if isSucessSong:
		$successfull_sound.play()
	else:
		$fail_sound.play()

# this is a helper function that allows a callback of a specified function
func receive_callback(callback):
	self.callback = callback

# this function let us pause the animation
func pause(isPaused):
	var animation_ball = get_node("animation_ball")
	if isPaused:
		animation_ball.play()
	else:
		animation_ball.stop(isPaused)

# calls next ball and remove this one from memory
func _on_animation_ball_animation_finished(anim_name):
	play_song()
	callback.call_func()

# when the sound is finished, the ball instance is removed from memory
func _on_fail_sound_finished():
	queue_free()  # ball instance

func _on_successfull_sound_finished():
	queue_free() 




