extends CharacterBody3D

signal set_movement_state(_movement_state : MovementState)
signal set_movement_direction(_movement_dircetion: Vector3)

@export var movement_states : Dictionary
@export var player : CharacterBody3D
var pp: float
var fricition_coeff: int  = 300
var movement_direction : Vector3
@export var player_id := 1 


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())



func _input(event):
	if !event.is_action("movement"):
		return
	movement_direction.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	movement_direction.z = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	##
	movement_direction.y = Input.get_action_strength("up") - Input.get_action_strength("down")
	##
	if is_movement_ongoing():
		if Input.is_action_pressed("sprint"):
			set_movement_state.emit(movement_states["Sprint"])
		elif Input.is_action_pressed("walk"):
			set_movement_state.emit(movement_states["Walk"])
		else: 
			set_movement_state.emit(movement_states["Run"])
	else:
		movement_direction = Vector3(0, 0, 0)
		set_movement_state.emit(movement_states["Stand"])

func _ready():
	if not is_multiplayer_authority(): return
	$CamRoot/CamYaw/CamPitch/SpringArm3D/Camera3D.current = true
	set_movement_state.emit(movement_states["Stand"])
	
	
func _physics_process(delta):
	if not is_multiplayer_authority(): return
	set_movement_direction.emit(movement_direction)

func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0 or abs(movement_direction.y) > 0
