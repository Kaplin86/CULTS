shader_type canvas_item;

uniform float threshold : hint_range(0.0,1.0) = 0.3;

void vertex() {

}

void fragment() {
	vec4 processingColor = texture(TEXTURE, UV);
	if (processingColor.r >= threshold) {
		COLOR = vec4(1,1,1,1);
	} else {
		COLOR = vec4(0,0,0,0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
