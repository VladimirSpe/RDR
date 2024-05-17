extends Node

signal set_cam_rotation(_cam_rotation : float)

@onready var yaw_node = $CamYaw
@onready var pitch_node = $CamYaw/CamPitch
@onready var camera_3d = $CamYaw/CamPitch/SpringArm3D/Camera3D

var yaw : float = 0.07 
var pitch : float = 0.07

var yaw_sensivity : float = 0.07
var pitch_sensivity : float = 0.07

var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

var pitch_max : float = 75
var pitch_min : float = -55

var tween : Tween

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensivity
		pitch += event.relative.y * pitch_sensivity

func _physics_process(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	
	yaw_node.rotation_degrees.y= lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta)
	pitch_node.rotation_degrees.x= lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta)

	set_cam_rotation.emit(yaw_node.rotation.y)

func _on_set_movement_state(_movement_state : MovementState):
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(camera_3d, "fov",_movement_state.camera_fov, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
