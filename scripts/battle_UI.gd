extends CanvasLayer

var attackButton
var attackButtonInstance
var attackParticles
var attackParticlesInstance
var attacked = false
var mouse_position
var enemyMaxHealth = 0.0
var enemyHealth = 0.0
var enemy
var ending = false

func _ready():
	attackButton = load("res://scenes/attack_button.tscn")
	attackParticles = load("res://scenes/attack_particles.tscn")
	enemyMaxHealth = enemy.health
	enemyHealth = enemy.health
	pass

func _process(_delta):
	$Node2D2/Node2D.scale.x = enemyHealth / enemyMaxHealth
	if enemyHealth <= 0:
		if ending == false:
			$Label.visible = true
			$Timer2.start()
			print("ending")
			ending = true
	pass

func attack():
	attackParticlesInstance = attackParticles.instance()
	attackParticlesInstance.position = mouse_position
	$"Node2D".call_deferred("add_child",attackParticlesInstance)
	enemyHealth -= 10
	pass

# attack button appear
func _on_Timer_timeout():
	if ending == false:
		if attackButtonInstance && attacked == false:
			attackButtonInstance.queue_free()
		attackButtonInstance = attackButton.instance()
		attackButtonInstance.position.x = rand_range(51.2,1484.8)
		attackButtonInstance.position.y = rand_range(51.2,848.8)
		$"Node2D".call_deferred("add_child",attackButtonInstance)
		attacked = false

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			mouse_position = event.position


func _on_Timer2_timeout():
	print("end")
	queue_free()
	enemy.queue_free()
	enemy.fightArea.queue_free()
	$"/root/Node2D/player".fighting = false
	$"/root/Node2D/player".started = false
	$"/root/Ui/fight_time".timerStarted = false
	pass
