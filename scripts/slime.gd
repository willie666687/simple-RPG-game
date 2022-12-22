extends Area2D

var player
var health = 100.0
var fightArea
func _ready():
	player = $"/root/Node2D/player"
	pass

func _process(_delta):
	if player.position.y > position.y:
		z_index = -1
	else:
		z_index = 1
	pass

func _on_slime_body_entered(body):
	if body == player && player.fighting == false:
		player.fighting = true
		var scene = load("res://scenes/fight_area.tscn")
		var instance = scene.instance()
		instance.position = position
		instance.scale.x = 8
		instance.scale.y = 8
		$"/root/Node2D".call_deferred("add_child", instance)
		player.enemy = self
		fightArea = instance
	pass
