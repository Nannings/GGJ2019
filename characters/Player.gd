extends KinematicBody2D

onready var dBox = preload("res://UI/dialogueBox.tscn")
onready var sprite = $sprite 
onready var animations = sprite.get_node("animations")
onready var flashLight = get_node("flashLight")

export (float) var battery = 1

signal dialogueDone

var direction = Vector2()
var movement = Vector2()
var speed = 9000
var maxSpeed = 9000 #make this heigher if it gets to slow
var facing = Vector2(0,-1)
var flashLightSprite 
var flashLightSprite2
var lightDecrease = 100 #less is faster
var switchLight = false
var flashLightActive = false;

func _ready():
	flashLightSprite = flashLight.get_node("flashLightSprite")
	flashLightSprite2 = flashLight.get_node("flashLightSprite2")
	
	var startScale = flashLightSprite.scale
	var tween = get_node("Tween")
	tween.interpolate_property(flashLightSprite, "scale", startScale, startScale * 1.01, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	pass

func _process(delta):
	speed = maxSpeed - Global.calculateWeight()
#	print(speed)

	if Input.is_key_pressed(KEY_P):
		flashLightActive = !flashLightActive
		if not flashLightActive:
			flashLightSprite2.visible = true
			flashLightSprite.visible = false
		else:
			flashLightSprite2.visible = false
			flashLightSprite.visible = true
	
	if not flashLightActive:
		flashLightSprite2.visible = true
		flashLightSprite.visible = false
	elif Input.is_key_pressed(KEY_K) && battery < 1 :
		flashLightSprite2.visible = false
		flashLightSprite.visible = true
		battery += delta / lightDecrease 
	else:
		battery -= delta / lightDecrease
	flashLightSprite.color = hsv_lerp(Color(0, 0, 0, 1), Color(1, 1, 1, 1), battery)

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
	if Input.is_action_pressed("up") || Input.is_action_pressed("down") || Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		if Input.is_action_pressed("up"):
			direction += Global.DIRECTIONS.up;
			flashLight.rotation_degrees = 180
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
	if Input.is_action_pressed("accept") && !Global.values.player.talking:
		if Global.values.inv.space.size() != 10:
			print("test1")
			for key in Global.ITEMS:
				if key == itemName:
						print("test2")
						Global.values.inv.space.append(itemName)
						print(Global.values.inv.space)
						if !item.get_owner().has_node("inside"):
							item.get_owner().queue_free()
						else:
							item.get_owner().get_node("pickArea").queue_free()
							if item.get_owner().get_node("inside").visible == true:
								item.get_owner().get_node("inside").visible = false
						var dBoxI = dBox.instance()
						print(Global.ITEMS[key].pickup)
						dBoxI.ini([],[Global.ITEMS[key].pickup], self)
						get_tree().get_root().add_child(dBoxI)
		else:
			itemName = "backpackFull"
			for key in Global.ITEMS:
				if key == itemName:
					print(Global.values.inv.space)				
					var dBoxI = dBox.instance()
					print(Global.ITEMS[key].pickup)
					dBoxI.ini([],[Global.ITEMS[key].pickup], self)
					get_tree().get_root().add_child(dBoxI)
	  
		
func talk(sceneScript):
	if Input.is_action_pressed("accept") && !Global.values.player.talking:
		Global.values.player.talking = true
		for key in Global.TALKS:
			if key == sceneScript:
				var speaker = []
				var dialogue = []
#				var voices = []
				for sent in Global.TALKS[key]:
					speaker.append(Global.TALKS[key][sent].speaker)
					dialogue.append(Global.TALKS[key][sent].text)
#					voices.append(Global.TALKS[key][sent].voice)
				var dBoxI = dBox.instance()
	
				dBoxI.ini(speaker, dialogue, self)
				get_tree().get_root().add_child(dBoxI)
				
func event(sceneScript,event):
	Global.values.player.talking = true
	for key in Global.TALKS:
		if key == sceneScript:
			
			var speaker = []
			var dialogue = []
#			var voices = []
			for sent in Global.TALKS[key]:
				speaker.append(Global.TALKS[key][sent].speaker)
				dialogue.append(Global.TALKS[key][sent].text)
#				voices.append(Global.TALKS[key][sent].voice)
			var dBoxI = dBox.instance()
			dBoxI.ini(speaker, dialogue, self)
			get_tree().get_root().add_child(dBoxI)
			event.queue_free()
			
			

#lower speed by 5% for 1 kg
func doneTalking():
	print("test")

func hsv_lerp(cola, colb, t):
    #This part will flip the direction of the lerp if the two colors are above
    #180 degrees apart, this way the lerp always takes the shortest path.
    var h
    var ha = cola.h
    var hb = colb.h
    var d = hb - ha
    if ha <= hb:
        if d > 0.5:
            h = fmod(lerp(ha + 1, hb, t), 1)
        else:
            h = lerp(ha, hb, t)
    else:
        d = -d
        if d > 0.5:
            h = fmod(lerp(ha, hb + 1, t), 1)
        else:
            h = lerp(ha, hb, t)

    #Setting the color
    var newcol = Color()
    newcol.v = lerp(cola.v, colb.v, t)
    newcol.s = lerp(cola.s, colb.s, t)
    newcol.h = h

    return newcol

func _on_Tween_tween_completed(object, key):
	var startScale = flashLightSprite.scale
	var tween = get_node("Tween")
	if switchLight == true:
		tween.interpolate_property(flashLightSprite, "scale", startScale, startScale * 1.01, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		switchLight = false
	else:
		tween.interpolate_property(flashLightSprite, "scale", startScale, startScale / 1.01, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		switchLight = true;
	tween.start()
