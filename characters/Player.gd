extends KinematicBody2D

onready var sprite = $sprite 

var direction = Vector2()
var movement = Vector2()
var speed = 8000
var facing = Vector2(0,-1)
var event
func _ready():
	pass

func _physics_process(delta):
	direction = Vector2(0,0)
	
	actions()
	walk()
	

	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			var collider = get_slide_collision(i).get_collider()
			if collider.is_in_group("items"):
				print(collider.name)


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
	if Input.is_action_pressed("pickup"):
		pass

