extends Node2D
class_name ItemComponent

# Nodes with this component as a child will be treated as "items" that can be picked up.
# Only nodes with InventoryComponent will be able to pick up items.
@onready var area: Area2D = $Area2D
var item_owner: Node = null

signal changed_owner(new_owner: Node)

func has_owner() -> bool:
	return item_owner != null

func set_item_owner(new_item_owner: Node) -> void:
	item_owner = new_item_owner
	changed_owner.emit(item_owner)

func get_item_owner() -> Node:
	return item_owner
