extends Control
class_name InventoryUI

# Getting player node
@onready var player_node = get_parent().get_parent()
@onready var inv_cmpnt: InventoryComponent = player_node.get_node("InventoryComponent")
@onready var grid: GridContainer = $GridContainer

# Preload the InventoryItemUI scene
@onready var InventoryItemUI = preload("res://ui/inventory_item_ui.tscn")

func _ready() -> void:
	display_inventory()

func display_inventory() -> void:
	for child in grid.get_children():
		child.queue_free()
	var items = inv_cmpnt.getInventory()
	for item_dict in items:
		if item_dict["item"] == null:
			continue
		var item_ui = InventoryItemUI.instantiate()
		var item_component = item_dict["item"]
		var quantity = item_dict["quantity"]

		grid.add_child(item_ui) # This needs to be done so the image and quantity can be set. Otherwise, item_ui's children won't be ready.
		
		# Set the item image and quantity
		item_ui.set_item_image(item_component.get_texture())
		item_ui.set_item_quantity(quantity)
		
		
