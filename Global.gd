extends Node #Make sure that global.gd extends Node, otherwise it won’t be loaded

const DIRECTIONS = {
	up = Vector2(0, -1),
	down = Vector2(0, 1),
	left = Vector2(-1, 0),
	right = Vector2(1, 0),
	}

var ITEMS

var root
var scene

var level = 1
var screen = 1

func _ready():
	root = get_tree().get_root()
	scene = root.get_child( root.get_child_count() -1 )
	loadJSON()
	#screen = get_viewport_rect().size 

func gotoScene(path):
	call_deferred("_deferred_gotoScene", path) #The call will take place on idle time (when it isn't executing code).
	
func loadJSON():
	var path = "res://data/items.JSON"
	var file = File.new()
	assert file.file_exists(path)
	
	file.open(path, file.READ)
	
	ITEMS = parse_json(file.get_as_text())
	emit_signal("JSON loaded")

func _deferred_gotoScene(path):
	print(path)
	scene.free()

	var res = ResourceLoader.load(path)
	scene = res.instance()
	root.add_child(scene)
