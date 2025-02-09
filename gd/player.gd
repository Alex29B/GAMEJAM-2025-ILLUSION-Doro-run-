extends CharacterBody3D

const SPEED = 5.0
const SENSITIVITY = 0.005
const SPRINT_SPEED = 12.0
var max_sprint = 200
var sprint_count = 0

const JUMP_VELOCITY = 3.5
var max_jumps = 3
var jump_count = 0

const BOB_FREQ = 2
const BOB_AMP = 0.1
var t_bob = 0

@onready var head = $Head2
@onready var camera = $Head2/Camera3D

var speed = SPEED

func default_mode():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(50))

func _physics_process(delta: float) -> void:
	#Handle sprint
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("sprint") and sprint_count < max_sprint:
		speed = SPRINT_SPEED
		sprint_count += 1
	else:
		speed = SPEED
		sprint_count -= 0.2
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
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob_walk(t_bob)
	
	move_and_slide()

func headbob_walk(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	return pos
