extends Node

signal upgrade_purchased(upgrade_id)

var upgrades = [
	{
		"id": "extra_time",
		"name": "Extra Time",
		"description": "Increase Timer by one second",
		"cost": 20,
		"base_cost": 20,
		"effect": "increase_time_value",
		"effect_value": 1,
		"cost_progression": 1.5,
		"max_upgrades": 999,
		"purchased_count": 0
	},
	{
		"id": "click_power",
		"name": "Click Power",
		"description": "Increase click value by 1",
		"cost": 50,
		"base_cost": 50,
		"effect": "increase_click_value",
		"effect_value": 1,
		"cost_progression": 1.5,
		"max_upgrades": 999,
		"purchased_count": 0
	},
	#{
		#"id": "cost_reduction",
		#"name": "Efficiency Expert",
		#"description": "Reduces cost growth of other upgrades",
		#"cost": 10,
		#"base_cost": 10,
		#"effect": "reduce_cost_progression",
		#"effect_value": 0.1,
		#"cost_progression": 1.5,
		#"max_upgrades": 5,
		#"purchased_count": 0
	#}
]

# Game state variables
var base_timer_duration = 5
var current_timer_duration = 5
var cost_reduction_level = 0

func _ready():
	update_all_upgrade_costs()

# Add this new function
func _on_button_pressed():
	# Reset currency to 0
	GameManager.currency = 0
	# Load the main scene
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func can_afford_upgrade(upgrade_data: Dictionary) -> bool:
	return GameManager.currency >= upgrade_data.cost

func is_upgrade_maxed(upgrade_data: Dictionary) -> bool:
	return upgrade_data.purchased_count >= upgrade_data.max_upgrades

func purchase_upgrade(upgrade_data: Dictionary) -> bool:
	if not can_afford_upgrade(upgrade_data):
		print("Not enough currency for upgrade: ", upgrade_data.name)
		return false
		
	if is_upgrade_maxed(upgrade_data):
		print("Upgrade already maxed: ", upgrade_data.name)
		return false
	
	# Deduct currency
	GameManager.currency -= upgrade_data.cost
	
	# Increment purchase count
	upgrade_data.purchased_count += 1
	
	# Apply upgrade effect
	apply_upgrade_effect(upgrade_data)
	
	# Update cost for next purchase
	update_upgrade_cost(upgrade_data)
	
	# If cost reduction was purchased, update all other upgrade costs
	if upgrade_data.id == "cost_reduction":
		update_all_upgrade_costs()
	
	# Emit signal
	emit_signal("upgrade_purchased", upgrade_data.id)
	
	print("Purchased %s for %d₡. Now at level %d/%d" % [
		upgrade_data.name,
		upgrade_data.cost,
		upgrade_data.purchased_count,
		upgrade_data.max_upgrades
	])
	return true

func apply_upgrade_effect(upgrade_data: Dictionary):
	match upgrade_data.effect:
		"increase_click_value":
			GameManager.click_power += upgrade_data.effect_value
			print("Click power increased to: %d" % GameManager.click_power)
		
		"increase_time_value":
			current_timer_duration += upgrade_data.effect_value
			print("Timer duration increased to: %ds" % current_timer_duration)
		
		"reduce_cost_progression":
			cost_reduction_level += 1
			print("Cost reduction level: %d (reduces multipliers by %.1f)" % [cost_reduction_level, cost_reduction_level * 0.1])
		
		_:
			print("Unknown upgrade effect: %s" % upgrade_data.effect)

func get_effective_cost_progression(base_progression: float) -> float:
	# Apply cost reduction: each level reduces progression by 0.1
	var reduced_progression = base_progression - (cost_reduction_level * 0.1)
	# Minimum progression of 1.0 (linear growth)
	return max(reduced_progression, 1.0)

func update_upgrade_cost(upgrade_data: Dictionary):
	if upgrade_data.id == "cost_reduction":
		# Cost reduction upgrade uses base progression (not affected by itself)
		upgrade_data.cost = int(upgrade_data.base_cost * pow(upgrade_data.cost_progression, upgrade_data.purchased_count))
	else:
		# Other upgrades use reduced progression
		var effective_progression = get_effective_cost_progression(upgrade_data.cost_progression)
		upgrade_data.cost = int(upgrade_data.base_cost * pow(effective_progression, upgrade_data.purchased_count))

func update_all_upgrade_costs():
	for upgrade in upgrades:
		update_upgrade_cost(upgrade)

func get_upgrade_by_id(upgrade_id: String) -> Dictionary:
	for upgrade in upgrades:
		if upgrade.id == upgrade_id:
			return upgrade
	return {}
