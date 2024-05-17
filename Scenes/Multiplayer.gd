extends TextureButton

var peer = ENetMultiplayerPeer.new()
const Player = preload("res://Scenes/Drone.tscn")

func _pressed():
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player(multiplayer.get_unique_id())
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	
	
func add_player(id):
	var player = Player.instantiate()
	player.name = str(id)
	add_child(player)
