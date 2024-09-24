extends Weapon

@onready var atk: Attack = $Attack
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var swordArea: Area2D = $Area2D
@export var attacking: bool = false

func attack():
	anim.stop()
	anim.play("attack")
	anim.queue("RESET")

func touchHurtboxArea(area: HurtboxComponent) -> void:
	hurt(area)

func hurt(area: HurtboxComponent):
	var body = area.get_parent()
	if "enemy" in body.get_groups() && attacking:
		area.damage(atk)
