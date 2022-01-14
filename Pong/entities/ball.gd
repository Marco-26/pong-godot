extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 9

func _ready():
	self.position = get_viewport_rect().size/2
	randomize()
	_get_random_direction()

func _get_random_direction():
	direction.x = [-1,1][randi() % 2]
	direction.y = [-0.8,0.8][randi()%2]
	return direction

func _physics_process(delta):
	var collision = move_and_collide(direction * speed)
	if collision != null:
		direction = direction.bounce(collision.normal)
