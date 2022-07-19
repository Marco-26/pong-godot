extends Control

onready var player_label = $player_score
onready var enemy_label = $enemy_score
onready var middle_line = $MiddleLine
onready var player_win = $player_win
onready var enemy_win = $enemy_win
onready var end_popup = $WindowDialog
onready var end_popup_text = $WindowDialog/LineEdit


var level_node = null

func _ready():
	middle_line.position.x = get_viewport_rect().size.x / 2
	enemy_label.text = str(Globals.enemy_score)
	player_label.text = str(Globals.player_score)
	
	level_node = get_parent()
	level_node.connect("change_score",self,"_handle_score")
	level_node.connect("winner_signal",self,"_handle_winner")
	
	
func _handle_score(score_goes_to):
	var score_target = score_goes_to
	
	match score_target:
		0:
			enemy_label.text = str(Globals.enemy_score)
			continue
		1:
			player_label.text = str(Globals.player_score)
			continue

func _handle_winner(winner):
	end_popup.visible = true
	if winner == "Player":
		end_popup_text.text = winner + " Wins"
	elif winner == "Enemy":
		end_popup_text.text = winner + " Wins"

func _on_WindowDialog_confirmed():
	#get_tree().change_scene_to(main_menu_scene)
	print("clicked")
	pass
