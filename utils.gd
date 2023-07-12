extends Reference
class_name Utils

# this function is responsible to instanciate all kinds of balls
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

static func check_prizes_bingo(card_numbers, drawn_balls):
	for x in card_numbers.size():
		if !drawn_balls.has(card_numbers[x]):
			return false
	return true

static func check_prizes_line(line, column, card_numbers, drawn_balls):
	var not_match = 0
	for x in line:
		for y in column:
			# if a drawn ball was not found on the card, the line is lost
			if !drawn_balls.has(card_numbers[column * x + y]):
				not_match += 1
				break
	return not_match

static func check_prizes_column(line, column, card_numbers, drawn_balls):
	var not_match = 0
	for x in column:
		for y in line:
			# if a drawn ball was not found on the card, the line is lost
			if !drawn_balls.has(card_numbers[column * y + x]):
				not_match += 1
				break
	return not_match

static func check_prizes_diagonal(line, card_numbers, drawn_balls):
	var not_match = 0
	var diagonal_left = true
	var diagonal_right = true
	for x in line:
		# if there's no match between drawn ball and card number when width and height position match(diagonal) not_match receives 1 and diagonals left is now false 
		if !drawn_balls.has(card_numbers[line * x + x]) and diagonal_left: 
			diagonal_left = false
			not_match += 1
		# if there's no match between drawn ball and card number when height and width position match(diagonal) not_match receives 1 and diagonals right is now false 
		if !drawn_balls.has(card_numbers[line * x + (line - 1 - x)]) and diagonal_right:
			diagonal_right = false
			not_match += 1
		# if both are false, then there's no prize on diagonals
		if !diagonal_left and !diagonal_right:
			break
	return not_match
