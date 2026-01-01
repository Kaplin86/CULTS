@tool
extends Node3D

func _process(_delta):
	var currentCamera : Camera3D = null
	if Engine.is_editor_hint():
		currentCamera = EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
	else:
		currentCamera = get_viewport().get_camera_3d()
	if !currentCamera:
		return
	var dir = global_position - currentCamera.global_position
	dir.y = 0
	dir = dir.normalized()
	
	var angle = atan2(dir.z, dir.x)
	var deg = rad_to_deg(angle) + 90.0
	
	deg += global_rotation_degrees.y
	
	if deg < 0:
		deg += 360.0
	var sector := int(round(deg / 45.0)) % 8
	var angleAngle = ["N","NW","W","SW","S","SE","E","NE"][sector]
	
	var newdir = global_position - currentCamera.global_position
	newdir = newdir.normalized()
	var newangle = rad_to_deg(atan2(newdir.y, Vector2(newdir.x, newdir.z).length()))

	var heightAngle = "L"
	if newangle > -10.0 and newangle < 10.0:
		heightAngle = "L"
	elif newangle <= -55.0 and newangle > -74.0:
		heightAngle = "H"
	elif newangle <= -74.0:
		heightAngle = "T"
	
	
	$Sprite3D.texture = load("res://followerSprites/"+angleAngle+"_"+heightAngle+".svg")
