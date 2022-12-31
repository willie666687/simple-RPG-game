extends "res://scripts/inventory.gd"
export var playerHealth = 100.0
export var playerMaxHealth = 100.0
export var playerAttack = 10.0
export var died = false
export var playerLevel = 1
export var playerXp = 0.0
export var attackDmg = 0
export var levelXp = 0
var swordDmg = 0

func _process(delta):
	level()
	countAtts()
	$"player health/Health bar/health top".scale.x = playerHealth / playerMaxHealth
	$"player health/Health bar/health center".scale.x = playerHealth / playerMaxHealth
	$"player health/Health bar/health bottom".scale.x = playerHealth / playerMaxHealth
	$"player xp".rect_scale.x = float(playerXp) / levelXp
	$"player health/Health bar/Health".text = str(playerHealth) + " / " + str(playerMaxHealth)
	if player.fighting == true:
		$"enemy health/enemy health bar/Node2D".scale.x = enemyHealth / enemyMaxHealth
		$"enemy health/enemy health bar".visible = true
	else:
		$"enemy health/enemy health bar".visible = false
	if playerHealth <= 0:
		playerHealth = 0
		if died == false:
			died = true
			$died.visible = true
			$died/Timer.start()
			get_tree().call_group("fight","died")
			player.visible = false

func level():
	levelXp = int(pow(playerLevel,2.5) + 25)
	if playerXp >= levelXp:
		playerXp -= levelXp
		playerLevel += 1

func countAtts():
	if $"/root/Ui".equipped in $"/root/Ui".itemAttDmg:
		swordDmg = $"/root/Ui".itemAttDmg[equipped]
	else:
		swordDmg = 0
	playerAttack = 9.0 + float(playerLevel*1)
	attackDmg = playerAttack + swordDmg
	if 100.0 + float(playerLevel*5) >= playerMaxHealth:
		playerHealth += (95.0 + float(playerLevel*5)) - playerMaxHealth
	playerMaxHealth = 95.0 + float(playerLevel*5)

func attack():
	enemyHealth -= attackDmg
	if enemyHealth <=0:
			enemyHealth = 0

func _on_Timer_timeout():
	player.global_position = player.spawnpoint
	died = false
	$died.visible = false
	player.visible = true

