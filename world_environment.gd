extends WorldEnvironment
var shader : ShaderMaterial = environment.sky.sky_material
var ramp : Gradient = shader.get_shader_parameter("tex").color_ramp

var dt = 0.0
func _process(delta):
	return
	dt += delta * 0.5
	print(ramp.offsets)
	ramp.set_offset(1,sin(dt) * 0.4 + 0.5)
	ramp.set_color(1,Color.from_hsv(dt * 0.1,0.51,1))
	ramp.set_color(2,Color.from_hsv(dt * -0.2,0.51,1))
