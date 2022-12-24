extends Node2D


var slime = preload("res://scenes/slime.tscn")

func _ready():
	pass
func _process(delta):
	if $slimes.get_child_count() < 25:
		var avoid_objects = [$"/root/Node2D/player",$"/root/Node2D/scene/campfire"]
		avoid_objects += $"/root/Node2D/scene/trees".get_children() + $"/root/Node2D/enemies/slimes".get_children() + $"/root/Node2D/scene/stones".get_children()
		var instance = slime.instance()
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
				if pos.distance_to(avoid_objects[i].global_position*10) < threshold:
					canSpawn = false
			if canSpawn == true:
				break
		$slimes.call_deferred("add_child",instance)
	pass
