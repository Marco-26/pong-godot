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
	yield(get_tree().create_timer(2), "timeout")
	
	if end_game == false:
		get_tree().reload_current_scene()
	else:
		_restart_game()

func _check_score():
	var winner
	# fazer sinal com o parametro de quem ganha o jogo para o hud atualizar a label winner
	var finish = 2
	if(Globals.enemy_score >= finish):
		winner = "Enemy"
		end_game = true
	elif(Globals.player_score >= finish):
		winner = "Player"
		end_game = true
	
	emit_signal("winner_signal", winner)

func _restart_game():
	Globals.enemy_score = 0
	Globals.player_score = 0
	get_tree().reload_current_scene()

func _on_RoundDelay_timeout():
	get_tree().paused = false
