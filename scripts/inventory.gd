extends CanvasLayer

# Add a dictionary to store the count of each item
var itemCount = {}
var itemDes = {
	"Wooden Sword" : "A simple wooden sword \nAttack + 5"
}
var itemAttDmg = {
	"Wooden Sword" : 5
}

var ItemNo
var SelectedItemtext
var opened = false
var enemyMaxHealth = 0.0
var enemyHealth = 0.0
var enemy
var ending = false
var player
var equipped

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
	itemCount["Wooden Sword"] = 1
	add_item("Nothing","Nothing")
	get_node("equip_button/GoButton").connect("pressed",self,"ReportListItem")
	player = $"/root/Node2D/player"

func ReportListItem():
	if opened == true:
		ItemNo = get_node("ItemList").get_selected_items()
		SelectedItemtext = $"ItemList".items[ItemNo[0]*3]
		get_node("Panel/Label - output").set_text(str(SelectedItemtext))
		$"equip_button/Label".text = SelectedItemtext
		$"equip_button/GoButton".icon = $"ItemList".items[ItemNo[0]*3+1]
		equipped = SelectedItemtext

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
	get_node("Panel/Label - output").set_text(str(SelectedItemtext) + " * " + str(itemCount[SelectedItemtext]) + "\n" + itemDes[SelectedItemtext])

func start():
	enemy = player.enemy
	enemyMaxHealth = enemy.health
	enemyHealth = enemy.health

# Add a method to add an item to the inventory
func add_item(item,des):
	if item in $"ItemList".items:
		if item in itemCount:
			# If the item already exists, increase the count
			itemCount[item] += 1
		
		else:
			# If the item doesn't exist yet, add it to the dictionary with a count of 1
			itemCount[item] = 1
			$"ItemList".add_item(item)
	else:
		$"ItemList".add_item(item)
		itemDes[item] = des
		itemCount[item] = 1
