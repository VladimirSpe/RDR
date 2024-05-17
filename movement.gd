extends Node

@export var rotated: Node3D	

@export var moveForce = 30

var parent: Node3D

const FORWARD_MULTIPLIER = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var forwardMultiplier = 1
	
	if Input.is_action_pressed("run") and Input.is_action_pressed("forward"):
		forwardMultiplier = FORWARD_MULTIPLIER
	elif Input.is_action_pressed("joy_l2"):
		forwardMultiplier = FORWARD_MULTIPLIER
		
	#var leftRight = clamp(Input.get_axis("left", "right") + Input.get_axis("joy_left", "joy_right"), -1.0, 1.0)
	#var forwardBack = clamp(Input.get_axis("forward", "back") + Input.get_axis("joy_forward", "joy_back"), -1.0, 1.0)
	#var upDown = clamp(Input.get_axis("down", "up") + Input.get_axis("joy_r1", "joy_r2"), -1.0, 1.0)
	
	var leftRight = clamp(Input.get_axis("left", "right"), -1.0, 1.0)
	var forwardBack = clamp(Input.get_axis("forward", "back"), -1.0, 1.0)
	var upDown = clamp(Input.get_axis("down", "up"), -1.0, 1.0)
	
	var moveVector = (rotated.basis.z * forwardBack * forwardMultiplier) + (rotated.basis.x * leftRight) + (rotated.basis.y * upDown)
	
	parent.apply_central_force(moveVector * moveForce)
	
func _on_set_cam_rotation(_cam_rotation : float):
	cam_rotation = _cam_rotation
