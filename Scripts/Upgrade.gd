extends Control

@export var normal_texture: Texture
@export var pressed_texture: Texture
#@onready var click_sound: AudioStreamPlayer = $ClickSound

func _ready():
	self.texture = normal_texture
	pass
	
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Switch to pressed texture when clicked
				if pressed_texture:
					self.texture = pressed_texture
			else:
				self.texture = normal_texture
	
func set_upgrade_data(upgrade):
	print(upgrade)
	
	var name_label: Label = $MarginContainer/VBoxContainer/Name
	var cost_label: Label = $MarginContainer/VBoxContainer/Cost
	
	# Set the name if you have a label for it
	name_label.text = upgrade.name
	cost_label.text = "Cost: " + str(upgrade.cost)
	
func buy_upgrade():
	GameManager.click_power +1;
	pass
	# check if conditions are met
	# apply upgrade
	# update upgrade costs
