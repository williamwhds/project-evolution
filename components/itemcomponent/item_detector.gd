extends Area2D

# A collision shape must be attached for the detector to work
@export var collision_shape : CollisionShape2D

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is ItemComponent:
		print("Got near an Item!")
