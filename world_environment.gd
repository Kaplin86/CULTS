extends WorldEnvironment
var shader : ShaderMaterial = environment.sky.sky_material
var ramp : Gradient = shader.get_shader_parameter("tex").color_ramp

var dt = 0.0
func _process(delta):
	
	var suspectedColor = Color.WHITE
	if References.boardHandler.currentPlayer:
		for I in References.boardHandler.currentPlayer.pool:
			for E in References.boardHandler.currentPlayer.pool[I]:
				suspectedColor = lerp(suspectedColor,References.boardHandler.typeToColor[I],0.5)
	
	ramp.set_color(1,ramp.get_color(1).lerp(suspectedColor,delta * 1))
	
	
