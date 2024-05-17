extends Node

var adress = "/root/Control/SideMenu/MainSceenQuit"
func _pressed():
	get_node(adress).visible = !get_node(adress).visible
