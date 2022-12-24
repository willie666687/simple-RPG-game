extends Area2D

var velocity
var player
var start = false

func _ready():
	player = $"/root/Node2D/player"
	var direction = $"/root/Node2D/player".global_position - global_position
	direction = direction.normalized()
	velocity = direction * 250

func _process(delta):
	if start == true:
		global_position += velocity * delta


func _on_slime_bullet_body_entered(body):
	if body == $"/root/Node2D/player/hitbox" && player.fighting == true:
		$"/root/Ui".playerHealth -= 15
		queue_free()

func _on_Timer_timeout():
	start = true


func _on_Timer2_timeout():
	queue_free()
	pass # Replace with function body.
