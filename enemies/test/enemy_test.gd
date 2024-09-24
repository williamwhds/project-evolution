extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var painSfx: Array[Node] = $Sfx/pain.get_children()
@onready var deathSfx: Array[Node] = $Sfx/death.get_children()
@onready var pathfind: PathfindComponent = $PathfindComponent
@onready var speedCmpnt: SpeedComponent = $SpeedComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent

var isDead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDead == false:
		velocity = pathfind.getDirection() * speedCmpnt.getSpeed()
		move_and_slide()

func _on_hurtbox_component_damaged() -> void: # When enemy is damaged
	painSfx.pick_random().play()

func _on_health_component_death_sequence() -> void:
	isDead = true
	$HurtboxComponent.queue_free() # Removing hurtbox to avoid emitting this signal multiple times
	var selectedSfx: AudioStreamPlayer2D = deathSfx.pick_random()
	selectedSfx.play()
	await selectedSfx.finished
	queue_free()
