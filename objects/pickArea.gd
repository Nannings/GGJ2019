extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func pickup():
	if get_overlapping_bodies() > 0:
		for i in range(get_overlapping_bodies()):
			var overlap = get_overlapping_bodies()[i]
			print(overlap)
			if overlap.is_in_group("player"):
				print(queue_free())
