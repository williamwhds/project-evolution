extends CharacterBody2D

# Maybe make it so the InventoryComponent returns the weapon instead of exporting it here?
# Might make it easier to manage the inventory and making enemy AI use weapons if I decide to do that.

@export var weapon: Weapon

@onready var speedCmpnt: SpeedComponent = $SpeedComponent
@onready var anim_player = $AnimatedSprite2D
@onready var invCmpnt: InventoryComponent = $InventoryComponent
@onready var item_detector: ItemDetector = $ItemDetector
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var hold_interact: HoldInteract = $CanvasLayer/HoldInteract

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	var speed = speedCmpnt.getSpeed() * 1000
	var direction = get_movement_direction()
	
	velocity = direction.normalized() * speed * delta
	circle_weapon()
	move_and_slide()
	change_animation()
	
	if Input.is_action_just_pressed("fire_weapon"):
		use_weapon()
	
	hold_interact_follow_first_nearby_item()

	if Input.is_action_just_pressed("interact") and hold_interact.visible:
		hold_interact.set_is_holding(true)
	elif Input.is_action_just_released("interact") or !hold_interact.visible:
		hold_interact.set_is_holding(false)

func get_movement_direction() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	return direction

func change_animation() -> void:
	if velocity.length() == 0:
		anim_player.frame = 1
		return
	
	var horizontal = velocity.x
	var vertical = velocity.y
	
	if vertical < 0:
		if horizontal > 0:
			anim_player.play("upright")
		elif horizontal < 0:
			anim_player.play("upleft")
		else:
			anim_player.play("up")
	elif vertical > 0:
		if horizontal > 0:
			anim_player.play("downright")
		elif horizontal < 0:
			anim_player.play("downleft")
		else:
			anim_player.play("down")
	elif horizontal > 0:
		anim_player.play("right")
	elif horizontal < 0:
		anim_player.play("left")

func circle_weapon() -> void:
	if weapon == null:
		return
	var mouse_position = get_global_mouse_position()
	var player_position = global_position
	var angle = (mouse_position - player_position).angle()
	var distance = 10  # Distance from the player to the weapon

	var weapon_position = player_position + Vector2(cos(angle), sin(angle)) * distance
	weapon.global_position = weapon_position
	weapon.rotation = angle

	# Flip the sprite if the mouse is to the left of the player
	if mouse_position.x < player_position.x:
		weapon.scale.y = -abs(weapon.scale.y)
	else:
		weapon.scale.y = abs(weapon.scale.y)

func use_weapon() -> void:
	if weapon == null:
		return
	weapon.attack()

# The following functions are for testing purposes ONLY. I'm just testing this system to see if it works.

func hold_interact_set_visible(new_visible: bool) -> void:
	hold_interact.visible = new_visible

func hold_interact_follow_node(node: Node2D) -> void:
	hold_interact.position = canvas.node_to_canvas_position(node)

# This looks ok-ish but ui element is following already owned items, and probably will follow items owned by other entities.
# Gonna need to fix this later.

func hold_interact_follow_first_nearby_item() -> void:
	var item = item_detector.get_first_nearby_item()
	if item == null:
		hold_interact_set_visible(false)
		return
	hold_interact_set_visible(true)
	hold_interact_follow_node(item)


# Picking up the item, adding it to the inventory, making it invisible, and reparenting it to the player.
func _on_hold_interact_hold_complete() -> void:
	var item = item_detector.get_first_nearby_item() as ItemComponent
	if item == null:
		return
	item_detector.nearby_items.erase(item)
	invCmpnt.addItem(item)
	item.set_item_owner(self)
	item.get_parent().visible = false
	item.get_parent().reparent(self)

#func pickup_all_nearby_items() -> void:
#	var item = item_detector.get_first_nearby_item()
#	
#	if item == null:
#		return
#	if item.get_item_owner() == self:
#		return
#	
#	item_detector.nearby_items.erase(item)
#	invCmpnt.addItem(item)
#	item.set_item_owner(self)
#	item.get_parent().visible = false
#	print(invCmpnt.getInventory())
#
#func get_weapon_from_inventory() -> void:
#	var weapon_item = invCmpnt.getInventory()[0]["item"]
#	if weapon_item == null:
#		print("No weapon in inventory!")
#		return
#	weapon = weapon_item.get_parent()
#	weapon.get_parent().remove_child(weapon) # Removing the weapon from the world
#	add_child(weapon) # Adding the weapon to the player's inventory component
#	weapon.visible = true # Weapon is now visible
#	weapon.global_position = global_position
#	add_child(weapon)
#	print("Got weapon from inventory!")
#	print(weapon)


