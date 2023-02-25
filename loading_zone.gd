class_name LoadingZone
extends Area2D


export var current_level: String
export var to_level: String
export var preserve_x: bool
export var preserve_y: bool


func _ready() -> void:
	var _discard = connect("body_entered", self, "_on_Area2D_body_entered")


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		# offset the player is away from the warp point.
		# e.g. going high would result in teleporting higher
		var offset = body.global_position - self.global_position
		
		var level: Node = load("res://levels/level_%s.tscn" % to_level).instance()
		Game.change_level_to(level)
		yield(level, "ready")
		
		var pos_node = Game.get_level().get_node("From_%s" % current_level)
		if pos_node != null:
			Game.get_player().global_position = pos_node.global_position
			if preserve_x:
				Game.get_player().global_position.x += offset.x
			if preserve_y:
				Game.get_player().global_position.y += offset.y
		
		if level is Level:
			GUI.update_level(level.display_name)
		else:
			GUI.update_level(to_level)
