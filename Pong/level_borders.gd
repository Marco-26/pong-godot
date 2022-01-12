extends Node2D

var ball = null
signal ball_collided

var wall_collided = null
enum walls {left, right}

func _ready():
	ball = get_parent().find_node("Ball")

func _on_Left_body_entered(body):
#	Enemy wins
	if body.is_in_group("Ball"):
		wall_collided = walls.left
		emit_signal("ball_collided", wall_collided)

func _on_Right_body_entered(body):
#	Player wins
	if body.is_in_group("Ball"):
		wall_collided = walls.right
		emit_signal("ball_collided", wall_collided)
