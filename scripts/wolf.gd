extends Area2D

var player
var health = 500.0
var fightArea
var tooth
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
	var scene = load("res://scenes/wolf_tooth.tscn")
	tooth = scene.instance()
	tooth.position.x =  (player.global_position.x - global_position.x) * 10 + rand_range(-2500,2500)
	tooth.position.y = (player.global_position.y - global_position.y) * 10 + rand_range(-2500,2500)
	call_deferred("add_child",tooth)
	$Timer.wait_time = rand_range(0.2,0.5)


func _on_Timer2_timeout():
	var scene = load("res://scenes/wolf_tooth.tscn")
	tooth = scene.instance()
	tooth.position.x =  (player.global_position.x - global_position.x) * 10 + rand_range(-2500,2500)
	tooth.position.y = (player.global_position.y - global_position.y) * 10 + rand_range(-2500,2500)
	call_deferred("add_child",tooth)
	$Timer2.wait_time = rand_range(0.2,0.5)
