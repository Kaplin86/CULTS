extends Camera3D

func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
	var viewportSize = get_viewport().get_visible_rect().size
	var Yprogress =  mousePos.y / get_viewport().get_visible_rect().size.y
	rotation_degrees.x = Yprogress * -1
	var Xprogress =  mousePos.x / get_viewport().get_visible_rect().size.x
	rotation_degrees.y = 26.0 + (Xprogress * -1) 
