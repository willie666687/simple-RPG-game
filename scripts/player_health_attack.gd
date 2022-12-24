extends "res://scripts/inventory.gd"
export var playerHealth = 100.0
export var playerMaxHealth = 100.0
export var playerAttack = 20.0

func _ready():
	pass


func _process(delta):
	$"player health/Health bar/health top".scale.x = playerHealth / playerMaxHealth
	$"player health/Health bar/health center".scale.x = playerHealth / playerMaxHealth
	$"player health/Health bar/health bottom".scale.x = playerHealth / playerMaxHealth
	$"player health/Health bar/Health".text = str(playerHealth) + " / " + str(playerMaxHealth)
	if player.fighting == true:
		$"enemy health/enemy health bar/Node2D".scale.x = enemyHealth / enemyMaxHealth
		$"enemy health/enemy health bar".visible = true
	else:
		$"enemy health/enemy health bar".visible = false
	pass
func attack():
	if $"/root/Ui".equipped in $"/root/Ui".itemAttDmg:
		enemyHealth -= playerAttack + $"/root/Ui".itemAttDmg[equipped]
	else:
		enemyHealth -= playerAttack
