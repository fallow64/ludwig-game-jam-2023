extends Level


onready var bunny_sprite = $DustBunny/AnimatedSprite
onready var collision_shape = $DustBunny/StaticBody2D/CollisionShape2D


func _ready():
	if !State.dust_bunny:
		bunny_sprite.play("burn")
		bunny_sprite.frame = 23
		collision_shape.disabled = true
