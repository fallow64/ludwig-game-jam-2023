extends Level


func _ready():
	if State.just_started:
		Fade.to_normal()
		State.just_started = false
		Game.get_player().can_move = false
		Game.get_player().get_node("AnimatedSprite").play("stand")
		yield(Game.get_player().get_node("AnimatedSprite"), "animation_finished")
		Game.get_player().can_move = true
		GUI.run_multiple_dialogue("Ludwig", ["Oh no... I guess that shrink ray really did work. I'm never doing another Amazon stream again.", "Where am I?"])
