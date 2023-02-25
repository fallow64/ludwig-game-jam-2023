class_name Interactable
extends StaticBody2D


# virtual function
func _get_interaction_text() -> String:
	return ""


# virtual function
func _interact() -> void:
	push_error("Virtual function not redefined")
