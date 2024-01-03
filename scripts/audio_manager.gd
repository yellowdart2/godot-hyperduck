# reference https://www.youtube.com/watch?v=mnm7uV4MOTk
extends Node


func play_music(stream: AudioStream):
	# check to make sure music isn't already playing
	if get_child_count() == 0:
		
		# the audio stream is an export of the level itself, so each level can
		# have different music
		var instance = AudioStreamPlayer.new()
		instance.stream = stream
		add_child(instance)
		instance.play()
