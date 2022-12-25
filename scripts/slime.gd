extends Area2D

var player
var health = 100.0
var fightArea
var bulletInstance
var regeneration = 2.5
var xp = 25

func _ready():
	player = $"/root/Node2D/player"
	pass

func _process(_delta):
	if player.position.y > position.y:
		z_index = -1
	else:
		z_index = 1
	if player.enemy == self && $"/root/Ui/Timer".time_left == 0:
		if $Timer.is_stopped() == true:
			$Timer.start()

func _on_slime_body_entered(body):
	if body == $"/root/Node2D/player/hitbox" && player.fighting == false:
		player.fighting = true
		var scene = load("res://scenes/fight_area.tscn")
		var instance = scene.instance()
		instance.position = self.global_position*10
		$"/root/Node2D".call_deferred("add_child", instance)
		player.enemy = self
		fightArea = instance
		get_tree().call_group("fight","start")


func _on_Timer_timeout():
	var scene = load("res://scenes/slime_bullet.tscn")
	bulletInstance = scene.instance()
	var r = rand_range(0,4)
	if r <= 1:
		bulletInstance.position.x += rand_range(550,800)
		bulletInstance.position.y += rand_range(-550,800)
	elif r > 1 && r <= 2:
		bulletInstance.position.x += rand_range(-550,800)
		bulletInstance.position.y += rand_range(550,800)
	elif r > 2 && r <= 3:
		bulletInstance.position.x += rand_range(-550,-800)
		bulletInstance.position.y += rand_range(-550,800)
	elif r > 3 && r <= 4:
		bulletInstance.position.x += rand_range(-550,800)
		bulletInstance.position.y += rand_range(-550,-800)
	fightArea.call_deferred("add_child", bulletInstance)
	$Slime.global_position = bulletInstance.position/1.25 + fightArea.global_position
