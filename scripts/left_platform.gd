extends StaticBody2D

var start_x
var start_y
var direction

const SPEED = 1
const MAX_DISTANCE = 75

func _ready():
	start_x = self.position.x
	start_y = self.position.y
	direction = -1
	
func _physics_process(_delta):
	self.position.x += direction * SPEED
	# if we've traveled too far, flip directions
	if (self.position.x < start_x - MAX_DISTANCE):
		direction *= -1
	if (self.position.x > start_x + MAX_DISTANCE):
		direction *= -1
