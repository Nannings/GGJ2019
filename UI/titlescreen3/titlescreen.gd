extends Control

onready var audio = get_node("AudioStreamPlayer2D")

func _ready():

	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	print("go to scene")
	get_tree().change_scene("res://levels/level1/livingroom.tscn")
	pass # replace with function body
