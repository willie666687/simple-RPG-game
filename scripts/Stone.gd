extends Sprite

func _process(_delta):
	if $"/root/Node2D/player".position.y > position.y - 110:
		z_index = -1
	else:
		z_index = 1
	pass

