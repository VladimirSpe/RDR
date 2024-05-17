extends Node
@export var player : CharacterBody3D


func _physics_process(delta):
	if (player.is_on_floor()):
		print(1)
	
