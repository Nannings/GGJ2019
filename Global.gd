extends Node #Make sure that global.gd extends Node, otherwise it won’t be loaded

const DIRECTIONS = {
	up = Vector2(0, -1),
	down = Vector2(0, 1),
	left = Vector2(-1, 0),
	right = Vector2(1, 0),
	}

var root
var scene

var level = 1
var screen = 1

func _ready():
	root = get_tree().get_root()
	scene = root.get_child( root.get_child_count() -1 )
	#screen = get_viewport_rect().size 

func gotoScene(path):
	call_deferred("_deferred_gotoScene", path) #The call will take place on idle time (when it isn't executing code).

func _deferred_gotoScene(path):
	print(path)
	scene.free()

	var res = ResourceLoader.load(path)
	scene = res.instance()
	root.add_child(scene)
