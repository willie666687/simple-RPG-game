extends Label

var timerStarted = false
var timer
func _process(delta):
	timer = $"../Timer"
	if $"/root/Node2D/player".fighting == true && timerStarted == false:
		timer.start()
		timerStarted = true
	if timerStarted == true:
		text = str(int($"../Timer".time_left))
		if timer.time_left <= 1 && $"../Timer".time_left != 0:
			text = "Fight!"
		if timer.time_left == 0:
			timer.stop()
			text = ""
	pass
