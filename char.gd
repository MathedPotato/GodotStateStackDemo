extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouseSensitivity := 0.3


func _init():
	Globals.playerChar = self;

# This function is mostly from the built-in CharacterBody3D template
func physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Back", "Forward")
	var direction = -$CamFocus/SpringArm.get_global_transform().basis.z * input_dir.y
	direction += $CamFocus/SpringArm.get_global_transform().basis.x * input_dir.x
	direction.y = 0
	direction = direction.normalized()
	if input_dir.normalized():
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func rotateCam(angleX: float, angleY: float):
	$CamFocus/SpringArm.rotate_x(angleX)
	$CamFocus.rotate_y(angleY)
	$CamFocus/SpringArm.rotation_degrees.x = clamp($CamFocus/SpringArm.rotation_degrees.x, -70, 70)


func input(input: InputEvent):
	if input is InputEventMouseMotion:
		#print("Mouse moved: x = {}, y = {}".format(input.relative.x, input.relative.y))
		rotateCam(deg_to_rad(-input.relative.y * mouseSensitivity),
			deg_to_rad(-input.relative.x * mouseSensitivity))
