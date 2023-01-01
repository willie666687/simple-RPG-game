extends Node2D

var slime = preload("res://scenes/slime.tscn")
onready var avoid_objects = [$"/root/Node2D/player",$"/root/Node2D/scene/campfire"]
var wolf = preload("res://scenes/wolf.tscn")

func _ready():
	pass
func _process(delta):
	spawn($slimes,slime,15)
	spawn($wolfs,wolf,5)
	pass

func spawn(monster,monsterScene,amount):
	if monster.get_child_count() < amount:
		avoid_objects += $"/root/Node2D/scene/trees".get_children() + $"/root/Node2D/enemies/slimes".get_children() + $"/root/Node2D/scene/stones".get_children()
		var instance = monsterScene.instance()
		var threshold = 1250
		instance.position.x = rand_range(-10000,10000)
		instance.position.y = rand_range(-10000,10000)
		var pos = Vector2(instance.position.x - 2960,instance.position.y + 720)
#		pos.distance_to($"/root/Node2D/scene/trees/Tree2".global_position*10) < threshold
		while true:
			instance.position.x = rand_range(-12500,12500)
			instance.position.y = rand_range(-12500,12500)
			pos = Vector2(instance.position.x - 2960,instance.position.y + 720)
			var canSpawn = true
			for i in range(avoid_objects.size()):
				if is_instance_valid( avoid_objects[i] ):
					if pos.distance_to(avoid_objects[i].global_position*10) < threshold:
						canSpawn = false
						break
			if canSpawn == true:
				break
		monster.call_deferred("add_child",instance)
