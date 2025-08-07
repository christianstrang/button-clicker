extends Node

signal currency_changed(new_currency)
var currency = 0
var click_power = 1

func _ready():
	pass
	
func increment_score():
	currency += click_power
	emit_signal("currency_changed", currency)

func spend_currency(amount: int) -> bool:
	if currency >= amount:
		currency -= amount
		emit_signal("currency_changed", currency)
		return true
	return false
