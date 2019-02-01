extends Control

onready var itemList = $Container/ItemList

var event
var inventoryArray = []
var currentSelected
var pathToItems = "res://objects/items/"

func _ready():
	visible = false
	inventoryArray = Global.values.inv.space
	pass

func _input(e):
	event = e

func  _process(delta):	
	if event != null:			
		if(Input.is_action_just_pressed("inventory")):
			visible = !visible
			itemList.clear()
			if visible:
				if inventoryArray.size() <= 0:
					itemList.add_item("nothing in backpack", null, true)
				else:
					for item in inventoryArray:
						itemList.add_item(item, null, true)
			

func _on_ButtonDropItem_pressed():
	if inventoryArray.size() > 0 && currentSelected != null:	
		var droppedItem = inventoryArray[currentSelected]
		inventoryArray.remove(droppedItem)
		var pathToItem = pathToItems + droppedItem + "/" + droppedItem + ".tscn"
		print(pathToItem)
		var itemScene = load(pathToItems + droppedItem + "/" + droppedItem + ".tscn")
		if itemScene != null:
			itemScene = load(pathToItems + droppedItem + "/" + droppedItem + ".tscn").instance()
			itemScene.global_position = Global.player.global_position
			itemScene.global_position += Vector2(2,0)
			itemScene.scale = Vector2(0.2, 0.2)
			get_node("/root/").add_child(itemScene)
			visible = false
		else:
			print("item is not present in dir")
	else:
		itemList.clear()
		itemList.add_item("nothing to drop!", null, true)

func _on_ItemList_item_selected(index):
	if inventoryArray.size() > 0:
		currentSelected = index

func _on_ButtonCloseInventory_pressed():
	visible = false
