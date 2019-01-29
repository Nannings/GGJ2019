extends Control

onready var dialogueSystem = get_node("/root/Canvas/DialogueSystem")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var label = $label
export (String) var sceneScript

func _ready():
	dialogueSystem.show(sceneScript)
	Global.values.player.talking = true
	

func _process(delta):
	if Input.is_action_pressed("accept"):
		Global.gotoScene("res://levels/level2/entrance.tscn")
	
