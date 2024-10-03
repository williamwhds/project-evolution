extends Control

# Getting player node
@onready var player_node = get_parent().get_parent()
@onready var inv_cmpnt: InventoryComponent = player_node.get_node("InventoryComponent")
@onready var grid: GridContainer = $GridContainer

func _ready() -> void:
	var items = inv_cmpnt.getInventory()
	for item in items:
		if item == null:
			continue
		var item_img = item.get_node("Sprite2D")
		grid.add_child(item_img)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
