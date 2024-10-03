extends Node2D
class_name InventoryComponent

@export var inventorySize : int = 10
var inventory : Array = []

func _ready():
    for i in range(inventorySize):
        inventory.append(null)

func addItem(item : Item):
    for i in range(inventorySize):
        if inventory[i] == null:
            inventory[i] = item
            break

func removeItem(item : Item):
    for i in range(inventorySize):
        if inventory[i] == item:
            inventory[i] = null
            break

func getItem(index : int) -> Item:
    return inventory[index]

func getInventory() -> Array:
    return inventory
