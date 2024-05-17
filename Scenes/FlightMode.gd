extends TextureButton

var adress = "/root/Control/FlightModePanel"


func _pressed():
	get_node(adress).visible = !get_node(adress).visible
