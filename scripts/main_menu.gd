extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file.bind("res://levels/level_001.tscn").call_deferred()


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
