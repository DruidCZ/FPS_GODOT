extends KinematicBody

#Set basic variableds
export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3
var velocity = Vector3()
var camera_x_rotation = 0

#Set onready variables
onready var head = $Head
onready var camera = $Head/Camera
onready var inspector = $Head/Camera/Inspector
#Lock cursor
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Mouselook
func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

#Show controls
func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

#Main control
func _physics_process(delta):
	
	#Set base direction for head
	var head_basis = head.get_global_transform().basis 
	var direction = Vector3()
	
	#Input forward and backward
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	
	#Input left and right
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	#Normalize vector
	direction = direction.normalized()
	
	#Velocity
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	#Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	#Move
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
	
	