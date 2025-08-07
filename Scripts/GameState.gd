extends Node

var base_timer_duration = 5
var current_timer_duration = 5
var cost_reduction_level = 0

func increase_timer_duration(amount: int):
	current_timer_duration += amount
	print("Timer duration increased to: %ds" % current_timer_duration)

func increase_cost_reduction():
	cost_reduction_level += 1
	print("Cost reduction level: %d" % cost_reduction_level)

func get_effective_cost_progression(base_progression: float) -> float:
	var reduced_progression = base_progression - (cost_reduction_level * 0.1)
	return max(reduced_progression, 1.0)
