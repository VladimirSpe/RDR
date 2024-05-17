extends Node

var adress = "/root/Control/SideMenu/ExitQuit"
func _pressed():
	get_node(adress).visible = !get_node(adress).visible
