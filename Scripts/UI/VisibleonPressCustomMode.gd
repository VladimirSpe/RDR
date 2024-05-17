extends Node

var adress = "/root/Control/CustomPanel"
func _pressed():
	get_node(adress).visible = !get_node(adress).visible
