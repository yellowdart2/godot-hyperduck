extends Node2D


@export var platform_queue = ["normal", "bounce", "left", "right", "limited"]

# grab a reference of each platform type so we can spawn them in later
@onready var normal_texture = preload("res://assets/normal_platform.png")
@onready var bounce_texture = preload("res://assets/bounce_platform.png")
@onready var limited_texture = preload("res://assets/limited_platform.png")
@onready var left_texture = preload("res://assets/left_platform.png")
@onready var right_texture = preload("res://assets/right_platform.png")

@onready var slot_1 = $"../Control/ui_panel/slot1"
@onready var slot_2 = $"../Control/ui_panel/slot2"
@onready var slot_3 = $"../Control/ui_panel/slot3"
@onready var slot_4 = $"../Control/ui_panel/slot4"
@onready var slot_5 = $"../Control/ui_panel/slot5"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var count = 0
	var position : Vector2 = Vector2(10, 170)

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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
		
	# this needs to move to wherever we actually instatiate these things
	#var platform = preload("res://scenes/limited_platform.tscn").instantiate()
	#self.add_child(platform)
