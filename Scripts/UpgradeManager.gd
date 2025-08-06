extends Node

var upgrades = [
	{
		"id": "time_increase",
		"name": "More Time",
		"description": "Increase Timer by one second",
		"cost": 10,
		"effect": "increase_time_value",
		"effect_value": 1,
		"cost_progression": 1.2,
		"max_upgrades": 55
	},
	{
		"id": "click_power",
		"name": "Click Power",
		"description": "Increase click value by 1",
		"cost": 100,
		"effect": "increase_click_value",
		"effect_value": 1,
		"cost_progression": 3,
		"max_upgrades": 10
	},
	{
		"id": "unlock_more_upgrades",
		"name": "More Upgrades",
		"description": "Unlock additional upgrades",
		"cost": 10000,
		"effect": "unlock_upgrades",
		"effect_value": 1,
		"cost_progression": 10,
		"max_upgrades": 10
	},
]
