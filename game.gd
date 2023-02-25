extends Node


export var initial_level: PackedScene
export var load_initial_level_on_ready := true

var current_level: Node
var current_path: String


func _ready() -> void:
	if load_initial_level_on_ready:
		load_initial_level()


func load_initial_level():
	for child in $GameSort.get_children():
		if child.name != "Player":
			child.queue_free()
	
	current_level = initial_level.instance()
	$GameSort.add_child(current_level)
	if current_level is Level:
		GUI.update_level(current_level.display_name)
	elif GUI.current_level.name.begins_with("Level"):
		GUI.update_level(current_level.name.substr(5))
	else:
		GUI.update_level("")


func change_level(path: String) -> void:
	var level_path := load(path)
	if level_path != null:
		var new_level: Node = level_path.instance()
		
		current_level.call_deferred("replace_by", new_level)
		current_level = new_level


func change_level_to(node: Node) -> void:	
	current_level.queue_free()
	$GameSort.call_deferred('add_child', node)
	current_level = node


func get_player() -> Player:
	return get_node("GameSort/Player") as Player


func get_level() -> Node:
	return current_level


func complete() -> void:
	get_player().get_node("Camera2D").trauma = 1
