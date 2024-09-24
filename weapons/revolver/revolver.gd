extends Weapon

@onready var atk: Attack = $Attack
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var bangSfx: Array[Node] = $Sfx/Bang.get_children()
@onready var wildwestSfx: Array[Node] = $Sfx/WildWest.get_children()
@onready var smokeParticle: GPUParticles2D = $Barrel/SmallSmokeParticle
@onready var sparkParticle: GPUParticles2D = $Barrel/SparkParticle


@onready var barrel: Marker2D = $Barrel
@onready var bullet_scene: PackedScene = preload("res://weapons/revolver/bullet.tscn")

func attack() -> void:
	create_bullet()
	bangSfx.pick_random().play()
	wildwestSfx.pick_random().play()
	smokeParticle.set_emitting(true)
	sparkParticle.restart()

func create_bullet() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = barrel.global_position
	bullet.rotation = self.rotation
	bullet.atk = self.atk
	get_parent().add_sibling(bullet)
