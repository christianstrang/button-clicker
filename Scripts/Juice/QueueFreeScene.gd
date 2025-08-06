# EffectBase.gd
extends Node

func _ready():
	# Auto-connect to AnimationPlayer if present
	if has_node("AnimationPlayer"):
		$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(_anim_name):
	queue_free()
