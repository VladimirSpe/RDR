extends Node

var adress = "/root/Control/FlightModePanel"

var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene

func _on_multiplayer_pressed():
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_disconnected.connect(add_player)
	add_player()
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	

func _on_multiplayer_2_pressed():
	var client = ENetMultiplayerPeer.new()
	client.create_client("127.0.0.1", 1027)
	multiplayer.multiplayer_peer = client

func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
	
func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	
func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local")
func _dell_player(id):
	get_node(str(id)).queue_free()


func _pressed():
	get_node(adress).visible = !get_node(adress).visible
