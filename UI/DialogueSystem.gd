extends Control

signal choiceEvent(title)

#onready var choice = preload("res://scenes/objects/choicesbox.tscn")
onready var speakerLabel = $speakerPanel.get_node("speaker")
onready var timeBetweenLetters = get_node("timeBetweenLetters")
onready var talklF = get_node("talklessFrames")
onready var rtl = $panel.get_node("rtl")
onready var audio = get_node("AudioStreamPlayer2D")
onready var portret = $panel.get_node("portret")

var speaker = []
var dialogue = []
var voices = []
var portrets = []
var page = 0
var choiceTime = false
var event
var beginPage 
var canSkip = false

func _ready():
	self.visible = false
	pass

func show(var diaName):
	$speakerPanel.visible = true	
	portret.visible = true		
	getDialogue(diaName)
	if dialogue.size() <= 0:
		print("dialgue NOT found")
		return	
	showDialogue()

func showItem(var itemName):
	$speakerPanel.visible = false
	portret.visible = false	
	for key in Global.ITEMS:
		if key == itemName:
			dialogue.append(Global.ITEMS[key].pickup)
	showDialogue()
	pass

func getDialogue(var sceneScript):
	for key in Global.TALKS:
		if key == sceneScript:
			for sent in Global.TALKS[key]:
				speaker.append(Global.TALKS[key][sent].speaker)
				dialogue.append(Global.TALKS[key][sent].text)
				portrets.append(Global.TALKS[key][sent].portret)
#				voices.append(Global.TALKS[key][sent].voice)
	print(speaker)
	print(dialogue)

func _input(e):
	event = e

func  _process(delta):	
	if event != null:
		var isSentenceDone = rtl.get_visible_characters() >= rtl.get_total_character_count()
		if isSentenceDone:
			timeBetweenLetters.stop()	
			
		if(Input.is_action_just_pressed("accept")) || beginPage == true:
			beginPage = false
			event = null
			if isSentenceDone:
				if page < dialogue.size()-1:
					page += 1				
					showDialogue()
					canSkip = false
				else:
					talklF.start()
					visible = false
						
			if not isSentenceDone:
				if Input.is_action_just_pressed("accept"):
					if canSkip:
						rtl.set_visible_characters(rtl.get_total_character_count())
						print(1)
				if Input.is_action_just_released("accept"):
					canSkip = true

func showDialogue():
	rtl.set_bbcode(dialogue[page])
	rtl.set_visible_characters(0)
	if speaker != []:
		speakerLabel.set_text(speaker[page])
	if portrets != []:
		portret.texture = load("res://UI/portret/" + portrets[page] + ".png")
	beginPage = true
	self.visible = true	
	timeBetweenLetters.start()

func reset():
	speaker = []
	dialogue = []
	portrets = []
	voices = []
	page = 0
	choiceTime = false

func play_voice(name):
	var file = File.new()
	var path = "res://voices/" + name + ".wav"
	if file.file_exists(path):
		audio.stream = load(path)
		audio.play()
		pass

func _on_talklessFrames_timeout():
	Global.values.player.talking = false
	talklF.stop()
	reset()

func _on_timeBetweenLetters_timeout():
	rtl.set_visible_characters(rtl.get_visible_characters() + 1)
	pass # replace with function body
