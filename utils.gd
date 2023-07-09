extends Reference
class_name Utils

static func create_instance(number):
	var ball_instance
		# instance our balls according to color
	if number in range(1, 11):
		ball_instance = preload("res://scenes/red_ball.tscn")
	elif number in range(11, 21):
		ball_instance = preload("res://scenes/blue_ball.tscn")
	elif number in range(21, 31):
		ball_instance = preload("res://scenes/pink_ball.tscn")
	elif number in range(31, 41):
		ball_instance = preload("res://scenes/green_ball.tscn")
	elif number in range(41, 51):
		ball_instance = preload("res://scenes/yellow_ball.tscn")
	else:
		ball_instance = preload("res://scenes/purple_ball.tscn")
	return ball_instance.instance()

 # this function returns an array of n shuffled numbers
static func generate_random_numbers(from, to, size):
	randomize()
	var arr = []
	for i in range(from, to):
		arr.append(i)
	arr.shuffle()
	arr.resize(size)
	return arr
	
# this function will convert a array coordinate into a pixel coordinate
static func array_to_pixel_convertion(x_start, y_start, column, row, offset):
	var new_x = x_start + offset * row
	var new_y = y_start + offset * column
	return Vector2(new_x, new_y)
