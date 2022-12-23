extends CanvasLayer

var ItemNo
var SelectedItemtext
var opened = false
var enemyMaxHealth = 0.0
var enemyHealth = 0.0
var enemy
var ending = false
var player
export var playerHealth = 100.0
export var playerMaxHealth = 100.0

func if_show(show : bool):
	if show==true:
		$"ItemList".visible = true
		$"Panel".visible = true
		$"Panel/Label - output".visible = true
	else:
		$"ItemList".visible = false
		$"Panel".visible = false
		$"Panel/Label - output".visible = false
func _ready():
	if_show(false)
	get_node("ItemList").select(0,true) #This sets a default so we don't have
	# to do error catching if an empty selection is captured.
	get_node("equip_button/GoButton").connect("pressed",self,"ReportListItem")
	player = $"/root/Node2D/player"

func ReportListItem():
	if opened == true:
		ItemNo = get_node("ItemList").get_selected_items()
		SelectedItemtext = $"ItemList".items[ItemNo[0]*3]
		get_node("Panel/Label - output").set_text(str(SelectedItemtext))
		$"equip_button/Label".text = SelectedItemtext
		$"equip_button/GoButton".icon = $"ItemList".items[ItemNo[0]*3+1]

func _process(_delta):
	if Input.is_action_just_pressed("open_inventory"):
		if opened == false:
			if_show(true)
			opened = true
		else:
			if_show(false)
			opened = false
	ItemNo = get_node("ItemList").get_selected_items()
	SelectedItemtext = $"ItemList".items[ItemNo[0]*3]
	get_node("Panel/Label - output").set_text(str(SelectedItemtext) + str(ItemNo))
	if player.fighting == true:
		$Node2D2/Node2D.scale.x = enemyHealth / enemyMaxHealth
		$Node2D2.visible = true
	else:
		$Node2D2.visible = false
	$"Health bar/health top".scale.x = playerHealth / playerMaxHealth
	$"Health bar/health center".scale.x = playerHealth / playerMaxHealth
	$"Health bar/health bottom".scale.x = playerHealth / playerMaxHealth
	$"Health bar/Health".text = str(playerHealth) + " / " + str(playerMaxHealth)

func attack():
	enemyHealth -= 10
func start():
	enemy = player.enemy
	enemyMaxHealth = enemy.health
	enemyHealth = enemy.health
