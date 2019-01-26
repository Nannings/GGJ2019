extends Control

signal choiceEvent(title)
signal scenarioEnd

#onready var choice = preload("res://scenes/objects/choicesbox.tscn")
onready var speakerLabel = $speakerPanel.get_node("speaker")
onready var timer = get_node("timeBetweenLetters")
onready var talklF = get_node("talklessFrames")
onready var rtl = $panel.get_node("rtl")
onready var audio = get_node("AudioStreamPlayer2D")

var speaker = []
var dialogue = []
var choices = []
var voices = []
var page = 0
var choiceTime = false
var event
var beginPage 

func ini(speakerData, dialogueData, choiceData, voiceData):
	speaker = speakerData
	dialogue = dialogueData
	choices = choiceData
	voices = voiceData

func _ready():
	rtl.set_bbcode(dialogue[page])
	if speaker != []:
		speakerLabel.set_text(speaker[page])
	rtl.set_visible_characters(0)
	beginPage = true
	print(speaker)
	print(dialogue)

func _input(e):
	event = e

	
func _process(delta):		
	hide()
	skip()
	nextPage()


func nextPage():
	set("visibility/visible",true)
	
	if event != null:
		if(Input.is_action_just_pressed("accept")) || beginPage == true:
			beginPage = false
			event = null
			if rtl.get_visible_characters() >= rtl.get_total_character_count():
				if page < dialogue.size()-1:
					page += 1
					rtl.set_bbcode(dialogue[page])
					speakerLabel.set_text(speaker[page])
					rtl.set_visible_characters(0)
					rtl.get_total_character_count()
					#for c in choices[page].values():
						#print(c)
						
				else:
					talklF.start()
					visible = false
					
			else:
				audio.stop()
				if voices[page] != "none":
					play_voice(voices[page])
				rtl.set_visible_characters(rtl.get_total_character_count())
			
			if rtl.get_visible_characters() <= 0:
				beginPage = true
					


func continueFile():
	page = page + 2
	choiceTime = false
	rtl.set_bbcode(dialogue[page])
	speakerLabel.set_text(speaker[page])
	rtl.set_visible_characters(0)
	
func hide():
	if event != null:
		if event.is_action_pressed("hideWindow"):
			event = null
			set("visibility/visible",!get("visibility/visible"))

func skip():
	if Input.is_action_pressed("skip"):
		set("visibility/visible",true)
		rtl.set_visible_characters(get_total_character_count())
		page += 1
		rtl.set_bbcode(dialogue[page])
		speakerLabel.set_text(speaker[page])

func reset():
	speaker = []
	dialogue = []
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
	print("working?")
	emit_signal("dialogueDone")
	get_tree().get_root().get_node("main").get_node("player").talking = false
	queue_free()
