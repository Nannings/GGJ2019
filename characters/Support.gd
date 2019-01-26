extends KinematicBody2D

onready var talkArea = $talkArea

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta): #Zet dit op de player en filter wat het is
	if talkArea.get_overlapping_bodies().size() > 1:
		for i in range(talkArea.get_overlapping_bodies().size()):
			var overlap = talkArea.get_overlapping_bodies()[i]
			if overlap.is_in_group("players"):
				overlap.talk("sceneScript")
