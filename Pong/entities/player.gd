extends KinematicBody2D

var speed = 8
var ball = null
var width
var height

func _ready():
	height = get_viewport_rect().size.y
	width = get_viewport_rect().size.x
	ball = get_parent().find_node('Ball')
	self.position.y = height/2
	self.position.x = 30

func _physics_process(delta):
	if ball.position.x < width/2:
		_aply_movement()

func _aply_movement():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
	move_and_collide(direction * speed)
	
