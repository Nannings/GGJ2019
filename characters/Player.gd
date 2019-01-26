extends KinematicBody2D

onready var dBox = preload("res://UI/dialogueBox.tscn")
onready var sprite = $sprite 
onready var animations = sprite.get_node("animations")
onready var flashLight = get_node("flashLight")


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

	print(direction)

	movement = speed * direction * delta
	move_and_slide(movement, Vector2(0,0))
	
func walk():
	if Input.is_action_pressed("up") || Input.is_action_pressed("down") || Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		if Input.is_action_pressed("up"):
			direction += Global.DIRECTIONS.up;
			flashLight.rotation_degrees = 180
			print(direction)
			if (!animations.current_animation == "walking_up" && !animations.current_animation == "walking_right" && !animations.current_animation == "walking_left"):
				animations.play("walking_up")
				
		elif Input.is_action_pressed("down"):
			direction += Global.DIRECTIONS.down;
			flashLight.rotation_degrees = 0
			if (!animations.current_animation == "walking_down" && !animations.current_animation == "walking_right" && !animations.current_animation == "walking_left"):
				animations.play("walking_down")
				
		if Input.is_action_pressed("right"):
			direction += Global.DIRECTIONS.right;
			flashLight.rotation_degrees = -90
			if (!animations.current_animation == "walking_right"):
				animations.play("walking_right")
				
		elif Input.is_action_pressed("left"):
			direction += Global.DIRECTIONS.left;
			flashLight.rotation_degrees = 90
			if (!animations.current_animation == "walking_left"):
				animations.play("walking_left")
	else:
		animations.stop()
		
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
				var choice = []
				for sent in Global.TALKS[key]:
					speaker.append(Global.TALKS[key][sent].speaker)
					dialogue.append(Global.TALKS[key][sent].text)
					for c in  Global.TALKS[key][sent].choice:
						choice.append(c)

				var dBoxI = dBox.instance()
				dBoxI.ini(speaker, dialogue, choice)
				get_tree().get_root().add_child(dBoxI)

		

