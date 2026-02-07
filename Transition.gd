extends CanvasLayer

var untagged = []
var todo = []
var dt = 0.0
var targetColor = Color.BLACK
var Gdelta = 0.1

func _process(delta):
	Gdelta = delta

func transition(wantedScene : String):
	targetColor = Color.BLACK
	var ramp : Gradient = $Sprite2D.texture.color_ramp
	ramp.set_color(0,Color(0.0, 0.0, 0.0, 0.0))
	
	while ramp.get_offset(0) <= 0.9:
		ramp.set_color(0,ramp.get_color(0).lerp(targetColor,Gdelta * 2))
		ramp.set_offset(0,lerp(ramp.get_offset(0),targetColor.a,Gdelta))
		await RenderingServer.frame_post_draw
	
	get_tree().change_scene_to_file(wantedScene)
	
	targetColor = Color(0.0, 0.0, 0.0, 0.0)
	while ramp.get_offset(0) != 0.0:
		ramp.set_color(0,ramp.get_color(0).lerp(targetColor,Gdelta * 2))
		ramp.set_offset(0,lerp(ramp.get_offset(0),targetColor.a,Gdelta))
		await RenderingServer.frame_post_draw
