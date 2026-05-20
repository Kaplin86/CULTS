extends Node3D

@export var visualChild : Node3D
@export var intensity = 2.0
@export var speed = 5.0
var startingHeight = null
var dt = 0
func _process(delta: float) -> void:
	dt += delta
	if visualChild:
		if startingHeight == null:
			startingHeight = visualChild.global_position.y
		visualChild.global_position.y = startingHeight + (sin(dt * speed) * intensity)
