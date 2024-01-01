extends Node2D

@onready var player = $Player
var player_x
var player_y


func _ready():
	RenderingServer.set_default_clear_color(Color8(32, 40, 61, 255))
	player_x = player.position.x
	player_y = player.position.y

func reset_player():
	player.position.x = player_x
	player.position.y = player_y 

func _physics_process(_delta):
	if player.position.y > 208:
		reset_player()
