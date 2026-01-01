extends Camera3D

@export var dist = 13.11
var processingDist = dist

var rotationProgress = 0
var cameraMoveSpeed = 0.8

func _process(delta: float) -> void:
	processingDist = lerp(processingDist,dist,0.1)
	global_position.x = sin(rotationProgress) * processingDist
	global_position.z = cos(rotationProgress) * processingDist
	look_at(Vector3.ZERO)
	
	if Input.is_action_pressed("ui_left"):
		rotationProgress -= delta * cameraMoveSpeed
	if Input.is_action_pressed("ui_right"):
		rotationProgress += delta * cameraMoveSpeed
	
	if References.uiHandler:
		if References.uiHandler.viewCards:
			dist = 16.0
		else:
			dist = 13.11
