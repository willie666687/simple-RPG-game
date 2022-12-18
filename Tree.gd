extends Sprite

func _process(_delta):
	if $"../../player".position.y > position.y+425:
		z_index = -1
	else:
		z_index = 1
	pass
