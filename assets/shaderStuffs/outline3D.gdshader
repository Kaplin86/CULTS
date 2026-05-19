shader_type spatial;
render_mode cull_front, unshaded;

uniform vec4 color : source_color = vec4(0,0,0,1);
uniform float width = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += NORMAL * width * 0.01;
}

void fragment() {
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
