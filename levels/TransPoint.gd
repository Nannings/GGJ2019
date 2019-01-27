extends Area2D

export (String) var levelPlusScene

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_transpoint_body_entered(body):
	if body.is_in_group("players"):
		Global.gotoScene("res://levels/"+ levelPlusScene +".tscn")
