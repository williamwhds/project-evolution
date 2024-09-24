extends Area2D
class_name HurtboxComponent

signal damaged

@export var healthComponent: HealthComponent

func damage(attack: Attack):
	if healthComponent:
		healthComponent.damage(attack)
		damaged.emit()
