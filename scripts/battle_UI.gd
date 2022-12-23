extends CanvasLayer

var attackButton
var attackButtonInstance
var attackParticles
var attackParticlesInstance
var attacked = false
var mouse_position
var ending = false
var enemy

func _ready():
	attackButton = load("res://scenes/attack_button.tscn")
	attackParticles = load("res://scenes/attack_particles.tscn")
	enemy = $"/root/Node2D/player".enemy
	pass

func _process(_delta):
	if $"/root/Ui".enemyHealth <= 0:
		if ending == false:
			$Won_text.visible = true
			$Timer2.start()
			print("ending")
			enemy.visible = false
			ending = true
	pass

func attack():
	attackParticlesInstance = attackParticles.instance()
	attackParticlesInstance.position = mouse_position
	$"Node2D".call_deferred("add_child",attackParticlesInstance)
	pass

# attack button appear
func _on_Timer_timeout():
	if ending == false:
		if attackButtonInstance && attacked == false:
			attackButtonInstance.queue_free()
			if $"/root/Ui".enemyHealth <= $"/root/Ui".enemyMaxHealth - 5:
				$"/root/Ui".enemyHealth += 2.5
		attackButtonInstance = attackButton.instance()
		attackButtonInstance.position.x = rand_range(51.2,1484.8)
		attackButtonInstance.position.y = rand_range(51.2,848.8)
		$"Node2D".call_deferred("add_child",attackButtonInstance)
		attacked = false

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			mouse_position = event.position

# ended
func _on_Timer2_timeout():
	print("end")
	enemy.fightArea.queue_free()
	enemy.queue_free()
	queue_free()
	$"/root/Node2D/player".fighting = false
	$"/root/Node2D/player".started = false
	$"/root/Ui/fight_time".timerStarted = false
	pass
