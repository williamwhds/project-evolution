extends Node2D

var speedMultiplier: float = 1.0
var atk: Attack

@onready var raycast: RayCast2D = $RayCast2D # Raycast is here only for colliding with walls. Damage is dealt by the Area2D
@onready var timer: Timer = $Timer
@export var speed: float = 1000.0
@export var bulletUptime: float = 0.2 # How long the bullet will be alive

func _ready() -> void:
	timer.start(bulletUptime)

func _process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * speedMultiplier * delta
	if raycast.get_collider() is TileMapLayer:
		queue_free()

func touchHurtboxArea(area: HurtboxComponent) -> void:
	hurt(area)
	queue_free()

func hurt(area: HurtboxComponent):
	var body = area.get_parent()
	if "enemy" in body.get_groups():
		area.damage(atk)

func _on_timer_timeout() -> void:
	queue_free()
