extends Node2D

# the platform queue itself
@export var platform_queue = ["normal", "bounce", "left", "right", "limited"]

# grab a reference of each platform types so we can spawn them in later
@onready var normal_texture = preload("res://sprites/normal_platform.png")
@onready var bounce_texture = preload("res://sprites/bounce_platform.png")
@onready var limited_texture = preload("res://sprites/limited_platform.png")
@onready var left_texture = preload("res://sprites/left_platform.png")
@onready var right_texture = preload("res://sprites/right_platform.png")

# grab a reference to the player for the spawn platform signal
@onready var player = $"../player"
@onready var world = $".."

# grab a reference to each of the UI sprites to we can assign the correct platform
# sprite to them
@onready var slot_1 = $"../Control/ui_panel/slot1"
@onready var slot_2 = $"../Control/ui_panel/slot2"
@onready var slot_3 = $"../Control/ui_panel/slot3"
@onready var slot_4 = $"../Control/ui_panel/slot4"
@onready var slot_5 = $"../Control/ui_panel/slot5"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# TODO: my brother in Christ there must be a better way to track the count of 
	# for loops
	var count = 0
	player.spawn_platform.connect(_on_spawn_platform)
	
	for i in platform_queue:
		if i == "normal":
			place_normal(count)
			count += 1
		if i == "bounce":
			place_bounce(count)
			count += 1
		if i == "left":
			place_left(count)
			count += 1
		if i == "right":
			place_right(count)
			count += 1
		if i == "limited":
			place_limited(count)
			count += 1

func redraw_platform_queue():
	var count = 0
	
	# clear all the sprites
	slot_1.set_texture(null)
	slot_2.set_texture(null)
	slot_3.set_texture(null)
	slot_4.set_texture(null)
	slot_5.set_texture(null)
	
	for i in platform_queue:
		if i == "normal":
			place_normal(count)
			count += 1
		if i == "bounce":
			place_bounce(count)
			count += 1
		if i == "left":
			place_left(count)
			count += 1
		if i == "right":
			place_right(count)
			count += 1
		if i == "limited":
			place_limited(count)
			count += 1

# TODO: the following functions are the dumbest hacks in the long, storied history
# of hacks in my career
func place_normal(x_offset):
	if x_offset == 0:
		slot_1.set_texture(normal_texture)
	if x_offset == 1:
		slot_2.set_texture(normal_texture)
	if x_offset == 2:
		slot_3.set_texture(normal_texture)
	if x_offset == 3:
		slot_4.set_texture(normal_texture)
	if x_offset == 4:
		slot_5.set_texture(normal_texture)

func place_bounce(x_offset):
	if x_offset == 0:
		slot_1.set_texture(bounce_texture)
	if x_offset == 1:
		slot_2.set_texture(bounce_texture)
	if x_offset == 2:
		slot_3.set_texture(bounce_texture)
	if x_offset == 3:
		slot_4.set_texture(bounce_texture)
	if x_offset == 4:
		slot_5.set_texture(bounce_texture)

func place_left(x_offset):
	if x_offset == 0:
		slot_1.set_texture(left_texture)
	if x_offset == 1:
		slot_2.set_texture(left_texture)
	if x_offset == 2:
		slot_3.set_texture(left_texture)
	if x_offset == 3:
		slot_4.set_texture(left_texture)
	if x_offset == 4:
		slot_5.set_texture(left_texture)
	
func place_right(x_offset):
	if x_offset == 0:
		slot_1.set_texture(right_texture)
	if x_offset == 1:
		slot_2.set_texture(right_texture)
	if x_offset == 2:
		slot_3.set_texture(right_texture)
	if x_offset == 3:
		slot_4.set_texture(right_texture)
	if x_offset == 4:
		slot_5.set_texture(right_texture)
	
func place_limited(x_offset):
	if x_offset == 0:
		slot_1.set_texture(limited_texture)
	if x_offset == 1:
		slot_2.set_texture(limited_texture)
	if x_offset == 2:
		slot_3.set_texture(limited_texture)
	if x_offset == 3:
		slot_4.set_texture(limited_texture)
	if x_offset == 4:
		slot_5.set_texture(limited_texture)
		
	# TODO: this needs to move to wherever we actually instatiate these things
	#var platform = preload("res://scenes/limited_platform.tscn").instantiate()
	#self.add_child(platform)

func spawn_normal_platform(x_pos, y_pos):
	var platform = preload("res://scenes/normal_platform.tscn").instantiate()
	platform.position.x = x_pos
	platform.position.y = y_pos + 5
	world.add_child(platform)
	
func spawn_bounce_platform(x_pos, y_pos):
	var platform = preload("res://scenes/bounce_platform.tscn").instantiate()
	platform.position.x = x_pos
	platform.position.y = y_pos + 5
	world.add_child(platform)

func spawn_limited_platform(x_pos, y_pos):
	var platform = preload("res://scenes/limited_platform.tscn").instantiate()
	platform.position.x = x_pos
	platform.position.y = y_pos + 5
	world.add_child(platform)
	
func spawn_left_platform(x_pos, y_pos):
	var platform = preload("res://scenes/left_platform.tscn").instantiate()
	platform.position.x = x_pos
	platform.position.y = y_pos + 5
	world.add_child(platform)

func spawn_right_platform(x_pos, y_pos):
	var platform = preload("res://scenes/right_platform.tscn").instantiate()
	platform.position.x = x_pos
	platform.position.y = y_pos + 5
	world.add_child(platform)

func _on_spawn_platform(x_position, y_position):
	print("Spawning: ", x_position, "x", y_position)
	if !platform_queue.is_empty():
		if platform_queue[0] == "normal":
			spawn_normal_platform(x_position, y_position)
		if platform_queue[0] == "bounce":
			spawn_bounce_platform(x_position, y_position)
		if platform_queue[0] == "limited":
			spawn_limited_platform(x_position, y_position)
		if platform_queue[0] == "left":
			spawn_left_platform(x_position, y_position)
		if platform_queue[0] == "right":
			spawn_right_platform(x_position, y_position)
		
		# remove the first platform from the queue if there is one
		platform_queue.remove_at(0)
	
	# redraw the UI element
	redraw_platform_queue()

