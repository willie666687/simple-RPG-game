extends Node2D

var bite = false

func _ready():
	pass

func _process(delta):
	if bite == true:
		$Area2D/WolfToothAttack.visible = true
		$Area2D2/WolfToothAttack.visible = true
		$Area2D.position.y -= 10
		$Area2D2.position.y += 10
		if $Area2D.position.y <= 50:
			queue_free()
		var colliding_bodies = $Area2D.get_overlapping_bodies() + $Area2D2.get_overlapping_bodies()
		if $"/root/Node2D/player/hitbox" in colliding_bodies:
			$"/root/Ui".playerHealth -= 20
			queue_free()
	pass

func _on_Timer_timeout():
	bite = true
	pass
