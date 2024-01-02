extends CharacterBody2D

# signals
signal limited_interaction
signal player_died
signal spawn_platform(player_x, player_y)
signal captured_key
signal reached_door

# external resources
@export var movement_data : PlayerMovementData

# get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# track if we're currently on a limited platform so we don't repeatedly emit signal
var limited_flag = false

# track double jumps
var double_jump_flag = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()

	var input_axis = Input.get_axis("move_left", "move_right")
	apply_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()

	move_and_slide()

	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
	# check for collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		# collision layers do not seem to work intuitively - we do not care
		# about collisions with objects on the static layer
		# KEY: 1 = player, 2 = spike, 4 = static, 8 = bounce, 16 = limited
		# 32 = door, 64 = key
		if (collision.get_collider().collision_layer == 2):
			limited_flag = false
			handle_death()
		if (collision.get_collider().collision_layer == 8):
			limited_flag = false
			handle_bounce()
		if (collision.get_collider().collision_layer == 16):
			if limited_flag == false:
				handle_limited_platform()
				limited_flag = true
		if collision.get_collider().collision_layer == 32:
			handle_door()
		if collision.get_collider().collision_layer == 64:
			handle_key()		
	if get_slide_collision_count() == 0:
		limited_flag = false
	
# physics functions
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func apply_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor:
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func handle_jump():
	if is_on_floor(): double_jump_flag = true
	
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = movement_data.jump_velocity
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
		# handle double jump
		if Input.is_action_just_pressed("jump") and double_jump_flag:
			velocity.y = movement_data.jump_velocity *.5
			double_jump_flag = false
			emit_signal("spawn_platform", position.x, position.y)

# animation functions
func update_animations(input_axis):
	# check if we're moving for the run animation
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		# we're not moving, so idle
		animated_sprite_2d.play("idle")
	
	# we're not on the floor, so we're jumping
	if not is_on_floor():
		animated_sprite_2d.play("jump")

# collision functions
func handle_bounce():
	velocity.y = movement_data.bounce_speed

func handle_limited_platform():
	# we've landed on a limited platform, so toggle the flag and emit the signal
	# for the limited_platform script
	limited_flag = true
	emit_signal("limited_interaction")

func handle_door():
	emit_signal("reached_door")

func handle_key():
	emit_signal("captured_key")
	
# state functions
func handle_death():
	# we're dead, so emit the signal for the level script
	emit_signal("player_died")
