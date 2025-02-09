extends CharacterBody3D

const SPEED = .11
const JUMP = .2
const ANGRYSPEED = 3
const ANGRYJUMP = 3
const ANGRYMODE = 1
const AGGRO = 50

@onready var nav_agent = $NavigationAgent3D

var speed = SPEED
var jump = JUMP

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var current_location = global_transform.origin
	if (nav_agent.distance_to_target() > AGGRO):
		speed = ANGRYSPEED
		jump = ANGRYJUMP
	else:
		speed = SPEED
		jump = JUMP
		
	if (nav_agent.distance_to_target() > 1):
		var prev_location = current_location
		var prev_position = nav_agent.distance_to_target()
		if current_location.x > nav_agent.target_position.x:
			current_location.x -= speed
		else:
			current_location.x += speed
		if current_location.z > nav_agent.target_position.z:
			current_location.z -= speed
		else:
			current_location.z += speed
		if (abs(prev_location.x - current_location.x) + abs(prev_location.z - current_location.z)) <= 1 and nav_agent.distance_to_target() > 2:
			current_location.y += jump
		rotate_y(0.5)
	global_position = global_position.move_toward(current_location, SPEED)
	move_and_slide()

func _on_doro_collision_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		body.default_mode()
		get_tree().change_scene_to_file("res://tscn/gameover_menu.tscn")
