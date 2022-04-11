extends Control

export var scene : PackedScene

func _on_Play_pressed():
	get_tree().change_scene_to(scene)

func _on_Quit_pressed():
	get_tree().quit()
