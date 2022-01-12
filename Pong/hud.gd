extends Control

onready var player_label = $player_score
onready var enemy_label = $enemy_score

var player_score = 0
var enemy_score = 0

var level_node = null

func _ready():
	level_node = get_parent()
	level_node.connect("change_score",self,"_handle_score")
	
func _handle_score(score_goes_to):
	var score_target = score_goes_to
	
	match score_target:
		0:
			Globals.enemy_score += 1
			enemy_label.text = str(Globals.enemy_score)
			continue
		1:
			Globals.player_score += 1
			player_label.text = str(Globals.player_score)
			continue
