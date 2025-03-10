extends CharacterBody3D

class_name Player

@onready var remoteCamera = $RemoteCamera as RemoteTransform3D

const SPEED := 2.0
const JUMP_VELOCITY := 4.5
const sensitivity := 0.5


var direction := Vector3.ZERO

func _ready() -> void:
	Global.player = self
	remoteCamera.remote_path = Global.camera.get_path()

func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	_jump()
	_move_direction()
	move_and_slide()


func _move_direction() -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	if input_dir:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().round()
		velocity += direction * SPEED
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED)


func _jump() -> void:
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

func  _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		remoteCamera.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		remoteCamera.rotation.x = clamp(remoteCamera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
