extends Node2D

@onready var currency: RichTextLabel = $Currency
@onready var upgrade_container: VBoxContainer = $UI/ScrollContainer/VBoxContainer

func _ready():
	currency.text = str(GameManager.currency) + "[font_size=42]₡[/font_size]"
	populate_upgrades()
	pass

func populate_upgrades():
	
	# Clear existing children
	for child in upgrade_container.get_children():
		child.queue_free()
	
	var available_upgrades = UpgradeManager.upgrades
	
	for upgrade in UpgradeManager.upgrades:
		var item = load("res://Scenes/Upgrade.tscn").instantiate()
		item.set_upgrade_data(upgrade)
		#item.connect("purchase_pressed", _on_upgrade_purchased)
		upgrade_container.add_child(item)


func _on_button_pressed() -> void:
	GameManager.currency = 0
	# Load the main scene
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
