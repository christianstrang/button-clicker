extends Label

var timer_started = false
var time_remaining = 5
var countdown_timer = null
var first_click_received = false

func _ready():
	# Set initial text
	text = str(time_remaining)
	
	# Create the timer
	countdown_timer = Timer.new()
	countdown_timer.wait_time = 1.0
	countdown_timer.one_shot = false
	countdown_timer.connect("timeout", _on_countdown_timeout)
	add_child(countdown_timer)
	
	# Connect to GameManager's currency_changed signal to detect first click
	GameManager.connect("currency_changed", _on_currency_changed)

func _on_currency_changed(new_currency):
	# Start the timer on first click
	if not first_click_received:
		first_click_received = true
		start_timer()

func start_timer():
	if not timer_started:
		timer_started = true
		countdown_timer.start()

func _on_countdown_timeout():
	time_remaining -= 1
	text = str(time_remaining)
	
	if time_remaining <= 0:
		countdown_timer.stop()
		# Transition to shop/upgrade page
		get_tree().change_scene_to_file("res://Scenes/Shop.tscn")

func reset():
	# Reset timer variables
	timer_started = false
	first_click_received = false
	time_remaining = 5
	text = str(time_remaining)
	countdown_timer.stop()
