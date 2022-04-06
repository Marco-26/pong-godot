extends Node2D

var world_borders = null

signal change_score

enum score_options {opponent, player}
var score_goes_to

onready var timer = $RoundDelay

func _ready():
	get_tree().paused = true
	timer.start()
	world_borders = find_node("Border",true,false)
	world_borders.connect("ball_collided", self, "_handle_ball_collisions")

func _process(delta):
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		
func _handle_ball_collisions(wall_collided):
	var wall = wall_collided
	match wall:
		0:
			score_goes_to = score_options.opponent
			Globals.enemy_score+=1
			continue
		1:
			score_goes_to = score_options.player
			Globals.player_score+=1
			continue
	_check_score()
	emit_signal("change_score", score_goes_to)
	get_tree().reload_current_scene()

func _check_score():
#	Quando chegar a 5, acabar o jogo
	print("Enemy: ",Globals.enemy_score)
	print("Player: ",Globals.player_score)

func _on_RoundDelay_timeout():
	get_tree().paused = false