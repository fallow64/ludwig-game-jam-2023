extends Node


var key_mask := 0
var has_lighter := false
var dust_bunny := true
var just_started := true


func add_key(number: int) -> void:
	key_mask = key_mask & (1 << number)
