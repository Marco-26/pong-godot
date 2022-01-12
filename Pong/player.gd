extends KinematicBody2D

var speed = 5

func _ready():
	self.position.y = get_viewport_rect().size.y/2
	self.position.x = 30
	

func _physics_process(delta):	
	_aply_movement()

func _aply_movement():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
	move_and_collide(direction * speed)
	
