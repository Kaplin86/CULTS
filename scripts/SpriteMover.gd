@tool
extends Node3D

@export var mat : StandardMaterial3D

@export var followerType : References.figureTypes = References.figureTypes.crimson

var visType = -2

@export var outline = false

func _ready() -> void:
	mat = StandardMaterial3D.new()
	mat.cull_mode = 2
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	
	for I : MeshInstance3D in  $model.get_children():
		I.set_surface_override_material(0,mat)
	changeType(followerType)

func changeType(type):
	var typeName = References.figureTypes.find_key(type)
	if mat:
		var texutre =  load("res://assets/models/cultistModel/"+str(typeName)+".png")
		mat.albedo_texture =texutre
		visType = followerType
		
		if outline:
			var shader = load("res://assets/shaderStuffs/outline3D.gdshader")
			mat.next_pass = shader
			print("next pass is ", mat.next_pass)
		else:
			mat.next_pass = null

func _process(_delta):
	if followerType != visType:
		pass
	changeType(followerType)
	
	return
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
