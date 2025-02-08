extends CharacterBody3D

const SPEED = .1
const JUMP = .1

@onready var nav_agent = $NavigationAgent3D

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var current_location = global_transform.origin
	if (nav_agent.distance_to_target() > 1):
		var prev_location = current_location
		if current_location.x > nav_agent.target_position.x:
			current_location.x -= SPEED
		else:
			current_location.x += SPEED
		if current_location.z > nav_agent.target_position.z:
			current_location.z -= SPEED
		else:
			current_location.z += SPEED
		if ((prev_location.x - current_location.x) + (prev_location.z - current_location.z)) < 1:
			current_location.y += JUMP
		rotate_y(0.5)
	global_position = global_position.move_toward(current_location, SPEED)
	move_and_slide()
