extends Node2D
class_name InventoryComponent

@export var inventorySize : int = 10
var inventory : Array = []

# TODO: Allow addItem() to add as many items as possible, and drop the remaining items on the ground instead of not adding them.
# This includes adding items with a quantity greater than the max stack size, which should be split into multiple stacks. 
#
# TODO: Allow changing the inventory size mid-game. This may require a function to remove items from the inventory if the new
# size is smaller.
#

func _ready():
	for i in range(inventorySize):
		inventory.append({"item": null, "quantity": 0})

func addItem(item : ItemComponent, quantity: int = 1):
	# error checking
	if quantity <= 0:
		printerr("InventoryComponent: Tried to add a non-positive quantity of items.")
		return
	if item == null:
		printerr("InventoryComponent: Tried to add a null item.")
		return
	if item.is_stackable() and quantity > item.get_max_stack_size():
		printerr("InventoryComponent: Tried to add more items than the stack size allows.")
		return

	for i in range(inventorySize):
		if inventory[i]["item"] == item and item.is_stackable() and item.get_max_stack_size() > inventory[i]["quantity"]:
			inventory[i]["quantity"] += quantity
			return
		elif inventory[i]["item"] == null:
			inventory[i]["item"] = item
			inventory[i]["quantity"] = quantity
			return

func removeItem(item : ItemComponent, quantity: int = 1):
	# error checking
	if quantity <= 0:
		printerr("InventoryComponent: Tried to remove a non-positive quantity of items.")
		return
	if item == null:
		printerr("InventoryComponent: Tried to remove a null item.")
		return
	
	for i in range(inventorySize):
		if inventory[i]["item"] == item:
			inventory[i]["quantity"] -= quantity
			if inventory[i]["quantity"] <= 0:
				inventory[i]["item"] = null
				inventory[i]["quantity"] = 0
			return

func getItem(index : int) -> Dictionary:
	return inventory[index]

func getInventory() -> Array:
	return inventory

func getFirstEmptySlot() -> int:
	for i in range(inventorySize):
		if inventory[i]["item"] == null:
			return i
	return -1
