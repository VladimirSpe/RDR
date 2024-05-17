extends Node

var adress = "/root/Control/SetingPanel"
func _pressed():
	get_node(adress).visible = !get_node(adress).visible
