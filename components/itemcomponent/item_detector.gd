extends Area2D

# A collision shape must be attached for the detector to work
@export var collision_shape : CollisionShape2D
var nearby_items: Array = []

func _on_item_entered(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.append(item)
		print("Entered an item!")

func _on_item_exited(area: Area2D) -> void:
	var item = area.get_parent() if area.get_parent() is ItemComponent else null
	if item != null:
		nearby_items.erase(item)
		print("Exited an item!")
