extends Node

var bgM = AudioStreamPlayer.new()

func play(song, loop, scene):
	if !scene.has_node("bgM"):
		scene.add_child(bgM)
		
	bgM.stream = load(song)
	bgM.play()
	
