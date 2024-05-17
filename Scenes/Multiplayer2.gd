extends TextureButton

var peer = ENetMultiplayerPeer.new()


func _pressed():
	var client = ENetMultiplayerPeer.new()
	client.create_client("127.0.0.1", 1027)
	multiplayer.multiplayer_peer = client
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	
