extends Control

onready var dBox = preload("res://UI/dialogueBox.tscn")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var label = $label
export (String) var sceneScript

func _ready():
	for key in Global.TALKS:
		if key == sceneScript:
			print(sceneScript)
			var speaker = []
			var dialogue = []
			for sent in Global.TALKS[key]:
				speaker.append(Global.TALKS[key][sent].speaker)
				dialogue.append(Global.TALKS[key][sent].text)
				
			var dBoxI = dBox.instance()
			dBoxI.ini(speaker, dialogue, self)
			get_tree().get_root().add_child(dBoxI)

func _process(delta):
	if Input.is_action_pressed("accept"):
		Global.gotoScene("res://levels/level2/entrance.tscn")
	
