extends StaticBody2D

var start_x
var start_y
var direction

const SPEED = 1
const MAX_DISTANCE = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	start_x = self.position.x
	start_y = self.position.y
	direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	self.position.x += direction * SPEED
	if (self.position.x < start_x - MAX_DISTANCE):
		direction *= -1
	if (self.position.x > start_x + MAX_DISTANCE):
		direction *= -1
