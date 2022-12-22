extends CanvasLayer

var ItemNo
var SelectedItemtext
var opened = false

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
	get_node("GoButton").connect("pressed",self,"ReportListItem")

func ReportListItem():
	if opened == true:
		ItemNo = get_node("ItemList").get_selected_items()
		SelectedItemtext = $"ItemList".items[ItemNo[0]*3]
		get_node("Panel/Label - output").set_text(str(SelectedItemtext))
		$"Label".text = SelectedItemtext
		$"GoButton".icon = $"ItemList".items[ItemNo[0]*3+1]

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
