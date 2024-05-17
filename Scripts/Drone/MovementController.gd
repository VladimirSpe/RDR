extends Node

@onready var player = $".."
@onready var mesh_root = $"../Visuals"
@export var rotation_speed : float = 8
@onready var yaw_node = $CamYaw

var direction : Vector3
var velocity : Vector3
var acceleration : float
var speed : float
var pp: float
var cam_rotation : float = 0
var horizontal_basis : Vector3
var angle_quat : Quaternion
var angle_qu : Quaternion
var angle_quat2 : Quaternion
var speed_coef : float 
var last_force: Vector3
var c: float
var jump_force: float = 0.5
var fricition_coeff: int  = 300
@export var air_resist_coef : float = 0.3
var rng 
var random_float : float


func _physics_process(delta):
	var result_force = Vector3(0, -2, 0)
	#velocity.x = speed * direction.normalized().x
	#velocity.z = speed * direction.normalized().z
	##
	#velocity.y = speed * direction.normalized().y
	##
	#player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	result_force += acceleration * direction.normalized() # Ma
	result_force -= velocity * air_resist_coef
	#print(result_force)
	#result_force = lerp(velocity / delta, result_force)
	#print(direction)
	if player.is_on_floor() and !Input.get_action_strength("up"):
		if abs(velocity.x) >= 0:
			pp = velocity.x
			if abs(pp) < (fricition_coeff * delta):
				pp = 0
			else:
				pp -= fricition_coeff * delta if pp > 0 else -fricition_coeff * delta
			velocity = Vector3(pp, velocity.y, velocity.z)
		if abs(velocity.z) >= 0:
			pp = velocity.z
			if abs(pp) < (fricition_coeff * delta):
				pp = 0
			else:
				pp -= fricition_coeff * delta if pp > 0 else -fricition_coeff * delta
			velocity = Vector3(velocity.x, velocity.y, pp)
		#velocity = Vector3.ZERO
		if abs(velocity.y) >= 0:
			pp = velocity.y
			if abs(pp) > 0.2:
				velocity = Vector3(velocity.x, -pp / 2, velocity.z)
			else:
				velocity = Vector3(velocity.x, 0, velocity.z)
	else:
		velocity += result_force * delta
		last_force = velocity
		#print(velocity)
	player.velocity = velocity
	
	#player.velocity = player.velocity.lerp(velocity, acceleration * delta)
		
	##
	horizontal_basis = velocity.cross(Vector3.UP).normalized()
	speed_coef = atan(velocity.length() / 15)
	angle_quat = Quaternion(horizontal_basis, speed_coef)
	##da
	
	##
	#var target_rotation = atan2(direction.x, direction.z)
	var target_rotation = cam_rotation
	angle_quat2 = Quaternion(Vector3.UP, target_rotation)
	angle_quat2 = angle_quat * angle_quat2
	##
	player.move_and_slide()
	
		
	##
	angle_quat2 *= mesh_root.quaternion.inverse()
	angle_quat2 = Quaternion(angle_quat2.get_axis(), lerp_angle(0, angle_quat2.get_angle(), rotation_speed * delta))
	mesh_root.rotate(angle_quat2.get_axis(), angle_quat2.get_angle())
	##
	if player.is_on_floor():
		angle_qu = Quaternion(horizontal_basis, speed_coef)
		angle_qu = Quaternion(angle_qu.get_axis(), deg_to_rad(180))
		if rad_to_deg(Quaternion(horizontal_basis, speed_coef).get_angle()) > 12: 
			mesh_root.rotate(angle_qu.get_axis(), angle_qu.get_angle())
		
	##
			

func _on_movement_state(_movement_state : MovementState):
	speed = _movement_state.movement_speed
	acceleration = _movement_state.acceleration
func _on_set_movement_direction(_movement_direction : Vector3):
	direction = _movement_direction.rotated(Vector3.UP, cam_rotation)
	
func _on_set_cam_rotation(_cam_rotation : float): 
	cam_rotation = _cam_rotation

