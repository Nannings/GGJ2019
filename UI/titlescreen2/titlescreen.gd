extends Control

onready var audio = get_node("AudioStreamPlayer2D")

func _ready():

	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	Global.gotoScene("res://levels/level1/livingroom.tscn")