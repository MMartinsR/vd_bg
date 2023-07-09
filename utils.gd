extends Reference
class_name Utils

static func create_ball_instance(number, isSmall):
	var ball_instance
	var path = "res://scenes/"
		# instance our balls according to color
	if number in range(1, 11):
		path += "red"
	elif number in range(11, 21):
		path += "blue"
	elif number in range(21, 31):
		path += "pink"
	elif number in range(31, 41):
		path += "green"
	elif number in range(41, 51):
		path += "yellow"
	else:
		path += "purple"
	if isSmall:
		path += "_board"
	path += "_ball.tscn"
	ball_instance = load(path)
	return ball_instance.instance()

 # this function returns an array of n shuffled numbers
static func generate_random_numbers(from, to, size):
	randomize()
	var arr = []
	for i in range(from, to + 1):
		arr.append(i)
	arr.shuffle()
	arr.resize(size)
	return arr
	
# this function will convert a array coordinate into a pixel coordinate
static func array_to_pixel_convertion(x_start, y_start, column, row, offset):
	var new_x = x_start + offset * row
	var new_y = y_start + offset * column
	return Vector2(new_x, new_y)
