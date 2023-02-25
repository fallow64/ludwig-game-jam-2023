extends CanvasLayer


func to_black():
	$AnimationPlayer.play("fade_to_black")


func to_normal():
	$AnimationPlayer.play("fade_to_normal")
