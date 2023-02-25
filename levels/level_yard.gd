extends Level


onready var lighter = $Lighter
onready var collision_shape = $Lighter/StaticBody2D/CollisionShape2D


func _ready():
	if State.has_lighter:
		lighter.visible = false
		collision_shape.disabled = true
