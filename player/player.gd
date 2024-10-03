extends CharacterBody2D

@export var weapon: Weapon

@onready var speedCmpnt: SpeedComponent = $SpeedComponent
@onready var anim_player = $AnimatedSprite2D
@onready var invCmpnt: InventoryComponent = $InventoryComponent

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
