extends Node

signal score_changed(new_score)
var score = 0

func _ready():
	pass
	
func increment_score():
	score += 1
	emit_signal("score_changed", score)
