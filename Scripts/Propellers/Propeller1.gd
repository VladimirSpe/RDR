extends Node3D

@onready var animation_player = $"AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		animation_player.play("Spin")
	else:
		animation_player.stop()
