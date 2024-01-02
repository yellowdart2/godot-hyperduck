extends CharacterBody2D

@export var movement_data : PlayerMovementData
signal limited_interaction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

var bouncing = false
var limited = false

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()

	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	
	if bouncing:
		bouncing = false
		handle_bounce()

	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.get_collider().name, ": ", collision.get_collider().collision_layer)
		# collision layers do not seem to work intuitively
		if (collision.get_collider().collision_layer == 8):
			limited = false
			handle_bounce()
		if (collision.get_collider().collision_layer == 2):
			limited = false
			handle_death()
		if (collision.get_collider().collision_layer == 16):
			if limited == false:
				handle_limited_platform()
				limited = true
	if get_slide_collision_count() == 0:
		limited = false
	
	#if Input.is_action_just_pressed("ui_accept"):
	#	movement_data = load("res://FasterMovementData.tres")

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_bounce():
	velocity.y = movement_data.bounce_speed

func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = movement_data.jump_velocity
	if not is_on_floor():
		if Input.is_action_just_released("ui_up") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor:
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func handle_bounce_platform():
	bouncing = true

func handle_limited_platform():
	limited = true
	emit_signal("limited_interaction")

func handle_death():
	print("Dead")
