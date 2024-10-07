extends Area2D
class_name ItemDetector

@export var collision_shape : CollisionShape2D # A collision shape must be attached for the detector to work
@export var can_detect_owned_items: bool = false # This may be useful for making a "steal item" system.
@export var inventory_component: InventoryComponent = null # Some functions may require an inventory component to work.

# TODO: can_detect_owned_items might be changed mid-game. Change _on_item_entered and _on_item_exited
# to handle possible bugs, like trying to remove an item from the nearby_items array that is not there.
# (Bool is false, player gets near item. Bool is true, player leaves item. _on_item_exited tries to
# remove item from nearby_items array, but it's not there.) This is a minor bug, but it's worth fixing.

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
		if item.has_owner() and not can_detect_owned_items:
			return
		nearby_items.append(item)
		item_entered.emit(item)
		# print("Entered an item!")

func _on_item_exited(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		if item.has_owner() and not can_detect_owned_items:
			return
		nearby_items.erase(item)
		item_exited.emit(item)
		# print("Exited an item!")

func get_first_nearby_item() -> ItemComponent:
	if nearby_items.size() > 0:
		return nearby_items[0]
	return null

func get_nearby_items() -> Array:
	return nearby_items
