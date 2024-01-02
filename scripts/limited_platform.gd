extends StaticBody2D

var attempts = 3
var label


# Called when the node enters the scene tree for the first time.
func _ready():
	# get reference to player node for signal
	var player = get_tree().get_nodes_in_group("player")[0]
	player.limited_interaction.connect(_on_player_limited_interaction)
	
	label = get_node("Label")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var format_string = "%d"
	var actual_string = format_string % attempts
	label.text = actual_string

func _on_player_limited_interaction():
	print("Handled")
	attempts -= 1
	print("Attempts: ", attempts)
	if attempts <= 0:
		self.queue_free()
