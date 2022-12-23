extends Area2D

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			var mouse_position = event.position
			var distance = mouse_position.distance_to(self.global_position)
			if distance <= 51.2:
				get_tree().call_group("fight","attack")
				$"/root/Node2D/player/battle_UI".attacked = true
				queue_free()
