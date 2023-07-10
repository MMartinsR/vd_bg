extends Node2D

export (String) var color
export (int) var speed
var callback
var isSucessSong = false
var isPlayedSong = false

func _ready():
	pass

func place_number(number, isSucessSong):
	$ball_number.text = str(number)
	self.isSucessSong = isSucessSong

func play_song():
	var path = "res://assets/sounds/"
	if isSucessSong:
		path += "successfull_match.mp3"
	else:
		path += "no_match.mp3"
	var file = File.new()
	isPlayedSong = true
	
	if file.file_exists(path):
		file.open(path, file.READ)
		var buffer = file.get_buffer(file.get_len())
		var stream = AudioStreamMP3.new()
		stream.data = buffer
		var audio = get_node("AudioStreamPlayer")
		audio.stream = stream
		audio.play()

# this is a helper function that allows a callback of a specified function
func receive_callback(callback):
	self.callback = callback

# calls next ball and remove this one from memory
func _on_animation_ball_animation_finished(anim_name):
	play_song()
	callback.call_func()
	#queue_free()


func _on_fail_sound_finished():
	queue_free()
	
func pause(isPaused):
	var animation_ball = get_node("animation_ball")
	if isPaused:
		animation_ball.play()
	else:
		animation_ball.stop(isPaused)
