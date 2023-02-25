extends Interactable


func _get_interaction_text() -> String:
	return "Lighter"


func _interact():
	GUI.run_multiple_dialogue("Ludwig", ["Hmm... a lighter. I should probably keep this."])
	yield(GUI, "dialogue_done")
	State.has_lighter = true
	
	get_parent().visible = false
	$CollisionShape2D.disabled = true
