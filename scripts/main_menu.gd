extends Control

@export var music: AudioStream

func _process(_delta):
	audio_manager.play_music(music)
	
func _on_play_pressed():
	get_tree().change_scene_to_file.bind("res://levels/level_001.tscn").call_deferred()


func _on_options_pressed():
	get_tree().change_scene_to_file.bind("res://scenes/options_menu.tscn").call_deferred()


func _on_quit_pressed():
	get_tree().quit()
