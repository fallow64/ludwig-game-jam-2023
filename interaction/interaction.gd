extends RayCast2D


var current_collider: Interactable

onready var interaction_label: Label = $"/root/GUI/CenterContainer/InteractLabel"
onready var interact_key :=  OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
onready var player = get_tree().get_nodes_in_group("players")[0]


func _process(_delta: float) -> void:
	if !player.can_move:
		return
	
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			
			interaction_label.visible = true
			
			var text: String = collider._get_interaction_text()
			if "%s" in text:
				text = text % interact_key
			update_label_text(text)
		
		if Input.is_action_just_pressed("interact"):
			collider._interact()
	elif current_collider:
		current_collider = null
		update_label_text("")


func update_label_text(text: String) -> void:
	if text == "":
		interaction_label.text = ""
		interaction_label.visible = false
	else:
		interaction_label.visible = true
		interaction_label.text = text
