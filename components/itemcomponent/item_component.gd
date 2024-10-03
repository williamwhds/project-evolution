extends Node2D
class_name ItemComponent

# Nodes with this component as a child will be treated as "items" that can be picked up.
# Only nodes with InventoryComponent will be able to pick up items.
@onready var area: Area2D = $Area2D
