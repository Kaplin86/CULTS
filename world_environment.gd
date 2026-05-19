extends WorldEnvironment
var shader : ShaderMaterial = environment.sky.sky_material
var ramp : Gradient = shader.get_shader_parameter("tex").color_ramp

var dt = 0.0

func _ready() -> void:
	environment.sky_custom_fov = 180.0
	var twin = create_tween()
	twin.set_trans(Tween.TRANS_CIRC)
	twin.set_ease(Tween.EASE_OUT)
	twin.tween_property(environment,"sky_custom_fov",70.0,1)

var firstSet = false
func _process(delta):
	
	var suspectedColor = Color.WHITE
	if References.boardHandler.currentPlayer:
		for I in References.boardHandler.currentPlayer.pool:
			for E in References.boardHandler.currentPlayer.pool[I]:
				suspectedColor = lerp(suspectedColor,References.typeToColor[I],0.5)
	
	ramp.set_color(1,ramp.get_color(1).lerp(suspectedColor,delta * 1))
	if !firstSet:
		firstSet = true
		ramp.set_color(1,suspectedColor)
	var modelNum = References.boardHandler.playerObjects.find(References.boardHandler.currentPlayer)
	if modelNum != -1:
		var model = $"../PlayerSprites".get_child(modelNum)
		print("model is ", model.name)
		print("children are", model.get_children()," and child 0 is", model.get_child(0))
		var mat = model.find_child("Node3D2").mat
		mat.albedo_color = lerp(mat.albedo_color,suspectedColor,0.5)
		print(modelNum)
	
