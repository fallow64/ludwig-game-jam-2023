extends Interactable


func _get_interaction_text() -> String:
	return "Key"


func _interact():
	Fade.to_black()
	yield(Fade.get_node("AnimationPlayer"), "animation_finished")
	GUI.run_multiple_dialogue("", ["You win! Congratulations. Here's your cookie."])
	yield(GUI, "dialogue_done")
	GUI.visible = false
