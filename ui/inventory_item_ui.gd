extends Control

@onready var item_image: TextureRect = $ItemImage
@onready var item_quantity: Label = $ItemQuantity

# Function to set the item image
func set_item_image(texture: Texture) -> void:
	item_image.set_texture(texture)

# Function to set the item quantity
func set_item_quantity(quantity: int) -> void:
	item_quantity.text = str(quantity)
