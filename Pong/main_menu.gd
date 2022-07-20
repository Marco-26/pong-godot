extends Control

export var level = "res://level.tscn"

func _on_Play_pressed():
	print(Globals.enemy_score)
	get_tree().change_scene(level)

func _on_Quit_pressed():
	get_tree().quit()
