extends CharacterBody3D

const JUMP = 5
const HYPERJUMP = 100
const SPEED = 5.0
const SENSITIVITY = 0.005
const SPRINT_SPEED = 10.0

@onready var head = $Head2
@onready var camera = $Head2/Camera3D

var speed = SPEED

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(50))

func _physics_process(delta: float) -> void:
	#Handle Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	#Handle Inputs
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("jump") && velocity.y == 0:
		velocity.y = JUMP
	if Input.is_action_just_pressed("menu"):
		velocity.y = HYPERJUMP
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
