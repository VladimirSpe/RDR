extends Node


var adress = "/root/Control/SideMenu/Panel"

func _pressed():
	get_node(adress).visible = !get_node(adress).visible
