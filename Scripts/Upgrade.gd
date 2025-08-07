extends Control

@export var normal_texture: Texture
@export var pressed_texture: Texture
#@onready var click_sound: AudioStreamPlayer = $ClickSound

var upgrade_data: Dictionary = {}
var shop_reference: Node = null

func _ready():
	self.texture = normal_texture
	
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Switch to pressed texture when clicked
				if pressed_texture:
					self.texture = pressed_texture
			else:
				self.texture = normal_texture
				buy_upgrade()
	
func set_upgrade_data(upgrade, shop_ref):
	upgrade_data = upgrade
	shop_reference = shop_ref
	
	var name_label: Label = $MarginContainer/VBoxContainer/Name
	var cost_label: Label = $MarginContainer/VBoxContainer/Cost
	
	name_label.text = upgrade.name
	cost_label.text = "Cost: " + str(upgrade.cost) + "₡"

func buy_upgrade():
	if upgrade_data.is_empty() or shop_reference == null:
		return
	
	var success = shop_reference.purchase_upgrade(upgrade_data)
	
	if success:
		var cost_label: Label = $MarginContainer/VBoxContainer/Cost
		cost_label.text = "Cost: " + str(upgrade_data.cost) + "₡"
		shop_reference.currency.text = str(GameManager.currency) + "[font_size=42]₡[/font_size]"
