extends Node2D

var world_borders = null

signal change_score

enum score_options {opponent, player}
var score_goes_to

func _ready():
	world_borders = find_node("Border",true,false)
	world_borders.connect("ball_collided", self, "_handle_ball_collisions")

func _process(delta):
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		
func _handle_ball_collisions(wall_collided):
	var wall = wall_collided
	match wall:
		0:
			print("Enemy wins")
			score_goes_to = score_options.opponent
			continue
		1:
			print("Player wins")
			score_goes_to = score_options.player
			continue
	emit_signal("change_score", score_goes_to)
#func _reset_game():
#	# recomeçar ronda
