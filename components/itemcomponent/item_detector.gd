extends Area2D

@export var collision_shape : CollisionShape2D # A collision shape must be attached for the detector to work
@export var can_detect_owned_items: bool = false # This may be useful for making a "steal item" system.
var nearby_items: Array = []

signal item_entered(item: ItemComponent) 
signal item_exited(item: ItemComponent)

func _ready() -> void:
	if collision_shape == null:
		printerr("Item Detector: No collision shape attached!")
		return

func _on_item_entered(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.append(item)
		item_entered.emit(item)
		# print("Entered an item!")

func _on_item_exited(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.erase(item)
		item_exited.emit(item)
		# print("Exited an item!")

func get_first_nearby_item() -> ItemComponent:
	if nearby_items.size() > 0:
		return nearby_items[0]
	return null

func get_nearby_items() -> Array:
	return nearby_items
