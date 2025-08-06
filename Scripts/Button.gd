extends Node2D

const RingEffect = preload("res://Scenes/Juice/RingEffect.tscn")
const NumberEffect = preload("res://Scenes/Juice/NumberEffect.tscn")

@export var normal_texture: Texture2D
@export var pressed_texture: Texture2D
@onready var sprite = $Area2D/Sprite2D

@onready var click_sound: AudioStreamPlayer = $ClickSound

func _ready():
	sprite.texture = normal_texture

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			sprite.texture = pressed_texture
		else:
			sprite.texture = normal_texture
			if get_rect().has_point(to_local(event.position)):
				_on_click(event)

func _on_click(event):
	
	var ringEffect = RingEffect.instantiate()
	add_child(ringEffect)

	var numberEffect = NumberEffect.instantiate()
	print(event.position)
	numberEffect.global_position = event.position + Vector2(-20, -20) #hack: better offset positioning
	get_tree().get_root().add_child(numberEffect)
	
	# Random pitch between 0.8 and 1.2
	click_sound.pitch_scale = randf_range(0.92, 1.08)
	click_sound.play()
	
	# Call score increment
	GameManager.increment_score()

func get_rect() -> Rect2:
	return Rect2(
		-sprite.texture.get_size() * 0.5,
		sprite.texture.get_size()
	)
