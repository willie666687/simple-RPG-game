extends Node2D


var slime = preload("res://scenes/slime.tscn")

func _ready():
	pass
func _process(delta):
	if $slimes.get_child_count() < 15:
		var avoid_objects = [$"/root/Node2D/scene/Tree2",$"/root/Node2D/player",$"/root/Node2D/scene/campfire"]
		var instance = slime.instance()
		var threshold = 1500
		instance.position.x = rand_range(-25000,25000)
		instance.position.y = rand_range(-25000,25000)
		var pos = Vector2(instance.position.x - 2960,instance.position.y + 720)
		while pos.distance_to($"/root/Node2D/scene/Tree2".global_position*10) < threshold || pos.distance_to($"/root/Node2D/player".global_position*10) < threshold || pos.distance_to($"/root/Node2D/scene/campfire".global_position*10) < threshold:
			# Generate new random positions and try again
			instance.position.x = rand_range(-25000,25000)
			instance.position.y = rand_range(-25000,25000)
			pos = Vector2(instance.position.x - 2960,instance.position.y + 720)
		$slimes.call_deferred("add_child",instance)
	pass
