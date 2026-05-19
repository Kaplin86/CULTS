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
		suspectedColor = getBoardColor(References.boardHandler.currentPlayer)
	
	ramp.set_color(1,ramp.get_color(1).lerp(suspectedColor,delta * 1))
	if !firstSet:
		firstSet = true
		ramp.set_color(1,suspectedColor)
	for I in References.boardHandler.playerObjects.size():
		if References.boardHandler.playerObjects[I] != References.boardHandler.currentPlayer:
			var model = $"../PlayerSprites".get_child(I)
			var mat = model.find_child("Node3D2").mat
			mat.albedo_color = lerp(mat.albedo_color,getBoardColor(References.boardHandler.playerObjects[I]),0.1)
	

func getBoardColor(player : PlayerResource):
	var suspectedColor = Color.WHITE
	for I in player.pool:
		for E in player.pool[I]:
			suspectedColor = lerp(suspectedColor,References.typeToColor[I],0.5)
	return suspectedColor
