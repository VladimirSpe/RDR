extends Node

func _pressed():
	get_node("../../../").visible = !get_node("../../../").visible
