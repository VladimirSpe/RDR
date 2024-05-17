extends Node

var adress = "/root/World/Control/Panel/Panel"
func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		get_node(adress).visible = !get_node(adress).visible


