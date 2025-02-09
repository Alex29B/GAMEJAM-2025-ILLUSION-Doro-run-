extends CharacterBody3D

const SPEED = .11
const JUMP = .2
const ANGRYSPEED = 3
const ANGRYJUMP = 3
const ANGRYMODE = 1
const AGGRO = 50

@onready var nav_agent = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _on_doro_collision_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		body.default_mode()
		get_tree().change_scene_to_file("res://tscn/gameover_menu.tscn")
