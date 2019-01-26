extends Control

signal choiceEvent(title)
signal scenarioEnd

#onready var choice = preload("res://scenes/objects/choicesbox.tscn")
onready var speakerLabel = get_node("speaker")
onready var timer = get_node("timeBetweenLetters")
onready var rtl = $panel.get_node("rtl")


var speaker = []
var dialogue = []
var page = 0
var choiceTime = false
var event

func ini(speakerData,dialogueData):
	speaker = speakerData
	dialogue = dialogueData

func _ready():
	rtl.set_bbcode(dialogue[page])
	if speaker != []:
		speakerLabel.set_text(speaker[page])
	rtl.set_visible_characters(0)
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
		event = null
		if rtl.get_visible_characters() >= rtl.get_total_character_count():
			print("aaaa")
			if page < dialogue.size()-1:
				page += 1
				rtl.set_bbcode(dialogue[page])
				speakerLabel.set_text(speaker[page])
				rtl.set_visible_characters(0)
			else:
				emit_signal("scenarioEnd")
				queue_free()
		else:
			print("bbbb")
			rtl.set_visible_characters(rtl.get_total_character_count())
					


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
