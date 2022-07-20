extends Control

onready var player_label = $player_score
onready var enemy_label = $enemy_score
onready var middle_line = $MiddleLine
onready var end_popup = $WindowDialog
onready var close_popup = $WindowDialog.get_close_button()
onready var end_popup_text = $WindowDialog/Label2

onready var main_menu_scene = "res://main_menu.tscn"

var level_node = null

func _ready():
	middle_line.position.x = get_viewport_rect().size.x / 2
	enemy_label.text = str(Globals.enemy_score)
	player_label.text = str(Globals.player_score)
	close_popup.visible = false
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

func _handle_winner(winner,final_score):
	end_popup.visible = true
	if winner == "Player":
		end_popup_text.text = winner + " Wins \n\n Total points: " + str(final_score)
	elif winner == "Enemy":
		end_popup_text.text = winner + " Wins \n\n Total points: " + str(final_score)

func _on_WindowDialog_confirmed():
	get_tree().change_scene(main_menu_scene)
