extends Control



func _on_back_pressed():
	get_tree().change_scene_to_file.bind("res://scenes/main_menu.tscn").call_deferred()
