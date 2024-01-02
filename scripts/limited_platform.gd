extends StaticBody2D

# for now, every limited platform is 3 attempts
var attempts = 3

# this is the reference to the local label node so we can draw text
@onready var label = $Label

func _ready():
	# get reference to player node so we can connect to the signal
	var player = get_tree().get_nodes_in_group("player")[0]
	player.limited_interaction.connect(_on_player_limited_interaction)

func _process(_delta):
	# we have to format a string so we can assign our variable to it
	var format_string = "%d"
	var actual_string = format_string % attempts
	label.text = actual_string

func _on_player_limited_interaction():
	# this is our callback for when the player collides with the platform
	attempts -= 1
	
	# if we're out of attempts, despawn the platform
	if attempts <= 0:
		self.queue_free()
