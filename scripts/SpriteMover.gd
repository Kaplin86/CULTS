@tool
extends Node3D

@export var mat : StandardMaterial3D

@export var followerType : References.figureTypes = References.figureTypes.crimson

var visType = -2

@export var outline = false
@export var doPiecesEffect = false

func _ready() -> void:
	mat = StandardMaterial3D.new()
	mat.cull_mode = 2
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mat.resource_local_to_scene = true
	
	for I : MeshInstance3D in  $model.get_children():
		I.set_surface_override_material(0,mat)
	changeType(followerType)
	
	if doPiecesEffect:
		mat.grow = true
		mat.grow_amount = 16.0
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CIRC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(mat,"grow_amount",0,3)
		

func changeType(type):
	var typeName = References.figureTypes.find_key(type)
	if mat:
		var texutre =  load("res://assets/models/cultistModel/"+str(typeName)+".png")
		mat.albedo_texture =texutre
		visType = followerType
		
		if outline:
			$outline.visible = true
			
		else:
			$outline.visible = false
		
		if $outline.get_surface_override_material(0).albedo_color != curAlbedo:
			$outline.get_surface_override_material(0).albedo_color = mat.albedo_color.darkened(2)
			curAlbedo = $outline.get_surface_override_material(0).albedo_color

var curAlbedo = null

func process(_delta):
	#if followerType != visType:
	#	changeType(followerType)
	
	#print(mat.resource_local_to_scene)
	#return
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
