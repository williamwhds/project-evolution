extends Node2D
class_name PathfindComponent

@export var nodeFollow: Node2D
@onready var navAgent: NavigationAgent2D = $NavigationAgent2D

func getDirection() -> Vector2:
	return to_local(navAgent.get_next_path_position()).normalized()
	
func makePath() -> void:
	navAgent.target_position = nodeFollow.position

func _on_timer_timeout() -> void:
	makePath()
