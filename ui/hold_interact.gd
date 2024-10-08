extends Control
class_name HoldInteract

# This is a UI element that will prompt the player to hold a button to interact with an object.
# TODO: Enlarge the range of the progress bar so it doesn't look choppy when filling up.

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextLabel
@onready var timer: Timer = $Timer

@export var label_text: String = "Hold to interact"
@export var hold_time: float = 0.5
var current_hold_time: float = 0.0
var is_holding: bool = false

signal hold_complete

func _ready() -> void:
	texture_progress_bar.value = 0
	texture_progress_bar.max_value = 1000  # Increase the range for smoother updates
	label.text = label_text
	timer.wait_time = hold_time

func set_label_text(new_text: String) -> void:
	label.text = new_text

func _process(delta: float) -> void:
	if is_holding:
		current_hold_time += delta
		texture_progress_bar.value = (current_hold_time / hold_time) * texture_progress_bar.max_value
		if current_hold_time >= hold_time:
			is_holding = false
			current_hold_time = 0
			texture_progress_bar.value = 0
			hold_complete.emit()
			print("Hold complete!")
	else:
		current_hold_time = 0
		texture_progress_bar.value = 0

func set_is_holding(value: bool) -> void:
	is_holding = value

	#How to use this function in another script:
	# if Input.is_action_just_pressed("interact"):
	# 	set_is_holding(true)
	# elif Input.is_action_just_released("interact"):
	# 	set_is_holding(false)
