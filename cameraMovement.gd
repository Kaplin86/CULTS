extends Camera3D

var dist = 0

func _ready() -> void:
	dist = Vector2(global_position.x,global_position.z).distance_to(Vector2.ZERO)

var rotationProgress = 0
var cameraMoveSpeed = 0.4

func _process(delta: float) -> void:
	global_position.x = sin(rotationProgress) * dist
	global_position.z = cos(rotationProgress) * dist
	look_at(Vector3.ZERO)
	
	if Input.is_action_pressed("ui_left"):
		rotationProgress -= delta * cameraMoveSpeed
	if Input.is_action_pressed("ui_right"):
		rotationProgress += delta * cameraMoveSpeed
