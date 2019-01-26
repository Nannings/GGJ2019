extends KinematicBody2D

onready var dBox = preload("res://UI/dialogueBox.tscn")
onready var sprite = $sprite 

var direction = Vector2()
var movement = Vector2()
var speed = 8000
var facing = Vector2(0,-1)
var talking = false

func _ready():
	pass

func _physics_process(delta):
	direction = Vector2(0,0)
	
	action()
	walk()
	
#	if get_slide_count() > 0: #can be problematic if it touches will it queue_free()
#		for i in range(get_slide_count()):
#			var collider = get_slide_collision(i).get_collider()
#			if collider.is_in_group("items"):
#				pass
#				print(collider.name)


	movement = speed * direction * delta
	move_and_slide(movement, Vector2(0,0))
	
func walk():
	if Input.is_action_pressed("up"):
	            direction += Global.DIRECTIONS.up;
	elif Input.is_action_pressed("down"):
	            direction += Global.DIRECTIONS.down;
	if Input.is_action_pressed("right"):
	            direction += Global.DIRECTIONS.right;
	elif Input.is_action_pressed("left"):
	            direction += Global.DIRECTIONS.left;
func action():
	pass
		
func pickup(itemName, item):
	if Input.is_action_pressed("accept"):
		for key in Global.ITEMS:
			if key == itemName:
				print(Global.ITEMS[key].pickup)
				item.get_owner().queue_free()
				var dBoxI = dBox.instance()
				dBoxI.ini([],[Global.ITEMS[key].pickup])
				get_tree().get_root().add_child(dBoxI)
	  
		
func talk(sceneScript):
	if Input.is_action_pressed("accept") && !talking:
		talking = true
		for key in Global.TALKS:
			if key == sceneScript:
				var speaker = []
				var dialogue = []
				for sent in Global.TALKS[key]:
					speaker.append(Global.TALKS[key][sent].speaker)
					dialogue.append(Global.TALKS[key][sent].text)

				var dBoxI = dBox.instance()
				dBoxI.ini(speaker,dialogue)
				get_tree().get_root().add_child(dBoxI)

		

