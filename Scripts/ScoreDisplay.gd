extends Node

@onready var currency: Label = $"."

func _ready():
	GameManager.currency_changed.connect(_on_currency_changed)
	
func _on_currency_changed(new_currency):
	self.text = str(new_currency)
