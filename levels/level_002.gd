extends Node2D

@export var music: AudioStream

@onready var player = $player
@onready var level_label = $Control/ui_panel/level_label

var reset_player_x
var reset_player_y

@export var has_key : bool = true

var current_scene

func _ready():
	RenderingServer.set_default_clear_color(Color8(32, 40, 61, 255))
	# set player's reset position
	reset_player_x = player.position.x
	reset_player_y = player.position.y
	player.player_died.connect(_on_player_died)
	player.captured_key.connect(_on_player_captured_key)
	player.reached_door.connect(_on_player_reached_door)
	current_scene = get_tree()
	print(current_scene)
	audio_manager.play_music(music)
	
func _physics_process(_delta):
	# check if the player fell off the screen
	if player.position.y > 208:
		reset_player()

func reset_player():
	player.position.x = reset_player_x
	player.position.y = reset_player_y 
	get_tree().change_scene_to_file.bind("res://levels/level_002.tscn").call_deferred()
	
func _on_player_died():
	reset_player()
	
func _on_player_captured_key():
	has_key = true
	var key_node = get_node("key")
	if key_node != null:
		key_node.queue_free()

func _on_player_reached_door():
	if has_key == true:
		print("Level complete")
		has_key = false
		get_tree().change_scene_to_file.bind("res://levels/level_003.tscn").call_deferred()
