extends Control

onready var itemlist = $panel.get_node("itemlist")

#space = global.values.inv.space

func _ready():
	var index = 0
	for item in space:
		if item != "empty":
			var slot = get_node("slot" + str(index))
			var texture = load(item.sprite)
			slot.get_node("sprite").set_texture(texture)
			slot.get_node("count").set("text", "x" + str(counts[index]))
				
			if selling && !slot.has_node("sellOption"):
				print("making option")
				var option = sellOption.instance()
				option.sellable(item,counts[index],index)
				slot.add_child(option)
			elif slot.has_node("sellOption"):
				slot.get_node("sellOption").sellable(item,counts[index],index)
		index +=1

func _on_inventory_exit_tree():
	global.values.inv.space = space
	global.values.inv.counts = counts

func add(item):
	var hasItem = false
	var hasItemIndex = 0
	var index = 0
	
	for stored in global.values.inv.space:
		if stored != "empty":
			if stored.name == item.name:
				hasItem = true
				hasItemIndex = index
			index +=1

	if hasItem:
		global.values.inv.counts[hasItemIndex] += 1
		print(global.values.inv.space)
		return true
	else:
		if global.values.inv.space.has("empty"):
			var emptySpot = global.values.inv.space.find("empty") 
			global.values.inv.space.insert(emptySpot,item)
			print(global.values.inv.space)
			global.values.inv.space.remove(emptySpot + 1)
			global.values.inv.counts[emptySpot] += 1
			return true 
		else:
			return false