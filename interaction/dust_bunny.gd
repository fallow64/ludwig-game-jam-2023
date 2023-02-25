extends Interactable


const without_lighter_dialogue = ["Wow, this is a very threatening dust bunny. I would like to go past it, but I'm oh so scared.",
	"Maybe I should get rid of it somehow?"]
const lighter_hint_dialogue = ["After looking at this dusty bunny eight times I suddenly came to the conclusion that I should get a lighter to burn it for some reason."]
const with_lighter_dialogue = ["I could use the lighter to set the dust bunny on fire! A fire hazard? Maybe, but who cares."]

onready var sprite: AnimatedSprite = $"../AnimatedSprite"
onready var collision_shape: CollisionShape2D = $CollisionShape2D

var times_interacted := 0

func _get_interaction_text() -> String:
	return "dust bunny"


func _interact():
	if !State.dust_bunny:
		return
	
	times_interacted += 1
	if !State.has_lighter:
		if times_interacted < 8:
			GUI.run_multiple_dialogue("Ludwig", without_lighter_dialogue)
		else:
			GUI.run_multiple_dialogue("Ludwig", lighter_hint_dialogue)
	else:
		GUI.run_multiple_dialogue("Ludwig", with_lighter_dialogue)
		yield(GUI, "dialogue_done")
		
		State.dust_bunny = false
		
		sprite.play("burn")
		yield(sprite, "animation_finished")
		collision_shape.disabled = true
