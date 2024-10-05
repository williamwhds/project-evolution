extends Area2D

# A collision shape must be attached for the detector to work
@export var collision_shape : CollisionShape2D
var nearby_items: Array = []

# Signals for when an item is entered or exited.
# These will also emit if the item has an owner.
# This might be useful for making an "item steal" mechanic.
signal item_entered(item: ItemComponent) 
signal item_exited(item: ItemComponent)

func _on_item_entered(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.append(item)
		item_entered.emit(item)
		print("Entered an item!")

func _on_item_exited(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.erase(item)
		item_exited.emit(item)
		print("Exited an item!")

func get_first_nearby_item() -> ItemComponent:
	if nearby_items.size() > 0:
		return nearby_items[0]
	return null

func get_nearby_items() -> Array:
	return nearby_items
