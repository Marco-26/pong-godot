extends Node2D

var world_borders = null

signal winner_signal
signal change_score

enum score_options {opponent, player}
var score_goes_to

var end_game = false

onready var timer = $RoundDelay

func _ready():
	get_tree().paused = true
	timer.start()
	world_borders = find_node("Border",true,false)
	world_borders.connect("ball_collided", self, "_handle_ball_collisions")

func _process(_delta):
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
	emit_signal("change_score", score_goes_to)
	
	_check_score()
	
	if Globals.end_game:
		_restart_game()
		return
	
	yield(get_tree().create_timer(2), "timeout")
	
	if Globals.end_game == false:
		print("OI")
		get_tree().reload_current_scene()

func _check_score():
	var winner
	var final_score
	var finish = 3
	
	if(Globals.enemy_score >= finish):
		winner = "Enemy"
		final_score = Globals.enemy_score
		Globals.end_game = true
	elif(Globals.player_score >= finish):
		winner = "Player"
		final_score = Globals.player_score
		Globals.end_game = true
	else:
		return
	
	emit_signal("winner_signal", winner,final_score)

func _restart_game():
	Globals.enemy_score = 0
	Globals.player_score = 0
	Globals.end_game = false

func _on_RoundDelay_timeout():
	get_tree().paused = false
