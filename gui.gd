extends CanvasLayer


signal dialogue_done(id)


onready var container = $AdvanceContainer
onready var fps_label = $FPSCount
onready var level_label = $LevelLabel
onready var name_label = $"%NameLabel"
onready var text_label = $"%TextLabel"
onready var text_tween = text_label.get_node("Tween")
onready var arrow = $"%Arrow"
onready var space_label = $"%PressSpaceLabel"

var is_running := false
var text_completed := false
var player: Node
var id


func _ready():
	randomize()


func _process(_delta: float) -> void:
	var fps := String(Engine.get_frames_per_second())
	fps_label.text = "tiny ludwig's big adventure\nfps: " + fps


func fade_in():
	pass
#	$Node2D/ColorRect/AnimationPlayer.play("fade_to_normal")


func update_level(level: String) -> void:
	if level == "":
		level_label.visible = false
	else:
		level_label.visible = true
		level_label.text = level


func run_multiple_dialogue(name: String, text: Array) -> void:
	for msg in text:
		run_dialogue(name, msg)
		yield(self, "dialogue_done")


func run_dialogue(name: String, text: String, signal_id = -1, duration = -1.0) -> void:
	player = get_tree().get_nodes_in_group("players")[0]
	
	text = text.replace("\\n", "\n")
	name_label.text = name
	text_label.text = text
	space_label.visible = false
	arrow.visible = false
	arrow.texture.pause = true
	container.visible = true
	
	is_running = true
	id = signal_id
	text_completed = false
	player.can_move = false
	
	if duration == -1.0:
		duration = len(text) * 0.03
	
	text_tween.interpolate_property(
			text_label,
			"visible_characters",
			0, len(text), duration)
	
	text_tween.start()


func end_dialogue() -> void:
	is_running = false
	container.visible = false
	player.can_move = true
	arrow.texture.pause = true
	space_label.visible = false
	emit_signal("dialogue_done", id)


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	text_completed = true
	arrow.visible = true
	space_label.visible = true
	arrow.texture.pause = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and text_completed and is_running:
		end_dialogue()


func _on_AdvanceContainer_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") and text_completed and is_running:
		end_dialogue()
