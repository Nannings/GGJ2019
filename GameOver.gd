extends Control

func _on_Button_pressed():
	print("restart")
	get_tree().change_scene("res://UI/titlescreen2/titlescreen.tscn")