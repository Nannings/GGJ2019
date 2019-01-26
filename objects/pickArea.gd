extends Area2D

export (String) var itemName = "sceneScript"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _physics_process(delta):
	if get_overlapping_bodies().size() > 1:
		for i in range(get_overlapping_bodies().size()):
			var overlap = get_overlapping_bodies()[i]
			if overlap.is_in_group("players"):
				overlap.pickup(itemName, self)