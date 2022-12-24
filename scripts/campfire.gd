extends Area2D

onready var player = $"/root/Node2D/player"

func _ready():
	pass
func _process(delta):
	if $"../../player".position.y > position.y+50:
		z_index = -1
	else:
		z_index = 1


func _on_campfire_body_entered(body):
	if body == $"/root/Node2D/player/hitbox" && player.fighting == false:
		player.spawnpoint = self.global_position
		$"/root/Ui".playerHealth = $"/root/Ui".playerMaxHealth
	pass
