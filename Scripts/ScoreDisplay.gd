extends Node

@onready var score: Label = $"."

func _ready():
	GameManager.score_changed.connect(_on_score_changed)
	
func _on_score_changed(new_score):
	self.text = str(new_score)
