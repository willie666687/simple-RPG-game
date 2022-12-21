extends CanvasLayer

func _ready():
	pass
func _process(delta):
#	if $Timer.time_left == 0:
#		var scene = load("res://scenes/attack_button.tscn")
#		var instance = scene.instance()
#		instance.position.x = rand_range(51.2,1484.8)
#		instance.position.y = rand_range(51.2,848.8)
#		$"Node2D".call_deferred("add_child",instance)
#		print("appeared")
	pass


func _on_Timer_timeout():
	var scene = load("res://scenes/attack_button.tscn")
	var instance = scene.instance()
	instance.position.x = rand_range(51.2,1484.8)
	instance.position.y = rand_range(51.2,848.8)
	$"Node2D".call_deferred("add_child",instance)
	print("appeared")
