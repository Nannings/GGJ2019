extends Node #Make sure that global.gd extends Node, otherwise it won’t be loaded

const DIRECTIONS = {
	up = Vector2(0, -1),
	down = Vector2(0, 1),
	left = Vector2(-1, 0),
	right = Vector2(1, 0),
	}

var ITEMS
var TALKS

var root
var scene

var level = 1
var time = 1000 #2000

var values = {
	player = {
		hp = 100,
		speed = 9000,
		happi = 0,
		talking = false
	},
	inv = {
		space = [],
	}
}

var player

func _ready():
	root = get_tree().get_root()
	scene = root.get_child( root.get_child_count() -1 )
	loadJSON()
	#screen = get_viewport_rect().size 

func gotoScene(path):
	call_deferred("_deferred_gotoScene", path) #The call will take place on idle time (when it isn't executing code).
	
func loadJSON(): 
	var file = File.new()
	
	var path = "res://data/items.json"
	assert file.file_exists(path)
	file.open(path, file.READ)
	
	ITEMS = parse_json(file.get_as_text()) #alle files in een keer laden, maar nog wel aan de juste constante koppelen

	
	path = "res://data/talks.json"
	assert file.file_exists(path)
	file.open(path, file.READ)
	
	TALKS = parse_json(file.get_as_text())

func _deferred_gotoScene(path):
	print(path)
#	if not scene:
	scene.free()
	
	var res = ResourceLoader.load(path)
	scene = res.instance()
	root.add_child(scene)
	

func getWeightOfItem(name):
	for item in ITEMS:
		if item == name:
#			print(ITEMS[item].slowdown)
			return(ITEMS[item].slowdown)
	return 0

func countItems():
	var count = 0;
	for item in Global.values.inv.space:
		if item != "empty":
			count += 1
	return count

func calculateWeight():
#	print(Global.values.inv)
	var weight = 0;
	var weightMultiplier = 25
	for item in Global.values.inv.space:
		if item != "empty":
			weight += getWeightOfItem(item) * weightMultiplier
	return weight
