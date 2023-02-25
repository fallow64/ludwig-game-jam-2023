class_name Player
extends KinematicBody2D

export var speed := 5 * 32
export var can_move := true
var flipped := false

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var interaction_ray_cast: RayCast2D = $InteractionRayCast


func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO
	
	if animated_sprite.animation == "stand":
		return
	
	if can_move:
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_up"):
			direction.y -= 1
		if Input.is_action_pressed("move_down"):
			direction.y += 1
	
	# if x is neutral, then don't change the flip
	if direction.x == -1:
		flipped = true
	elif direction.x == 1.0:
		flipped = false
	
	if direction.length() == 0:
		animated_sprite.play("idle")
		return
	
	animated_sprite.flip_h = flipped
	direction = direction.normalized()
	
	# play animations
	var velocity := move_and_slide(direction * speed)
	if velocity.length() != 0:
		animated_sprite.play("run")
	else: # if something totally stops the player, then play the idle animation because no movement
		animated_sprite.play("idle")
	
	interaction_ray_cast.rotation = direction.angle()


func _on_AnimatedSprite_animation_finished() -> void:
	if animated_sprite.animation == "stand":
		animated_sprite.play("idle")
