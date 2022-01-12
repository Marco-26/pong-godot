extends KinematicBody2D

var speed = 4.5
var direction = Vector2.ZERO

var ball = null
var width = Vector2.ZERO

func _ready():
	width.x = get_viewport_rect().size.x/2
	ball = get_parent().find_node("Ball")

func _physics_process(delta):
	if ball.position.x < width.x:
		return
	
	move_and_collide(Vector2(0,_get_ball_position()*speed))

func _get_ball_position():
	if abs(ball.position.y - self.position.y) > 25:
		if ball.position.y > self.position.y:
			return 1
		elif ball.position.y < self.position.y:
			return -1
	else:
		return 0
