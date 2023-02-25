class_name Inspectabl
extends Interactable


export var doer := ""
export var object_name := ""
export(String, MULTILINE) var dialogue := ""


func _get_interaction_text() -> String:
	return object_name


func _interact():
	var dialogue_slices := dialogue.split("\n\n")
	GUI.run_multiple_dialogue(doer, dialogue_slices)
