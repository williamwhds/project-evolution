extends Node2D
class_name HealthComponent

signal death_sequence

@export var maxHealth: float = 10.0
var health: float

func _ready() -> void:
	health = maxHealth
	
func damage(attack: Attack):
	health -= attack.attackDamage
	if health <= 0:
		death_sequence.emit()
