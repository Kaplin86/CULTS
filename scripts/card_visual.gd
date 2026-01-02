extends Control
@export var defaultCardSize = Vector2(112.0,169.4)
@export var defaultHoverSize = Vector2(148.0,169.85)


func _process(delta):
	if References.uiHandler.hoverCard == self:
		custom_minimum_size = lerp(size,defaultHoverSize,0.1)
	else:
		custom_minimum_size = lerp(size,defaultCardSize,0.1)
		

func _on_mouse_entered():
	References.uiHandler.hoverCard = self


func _on_mouse_exited():
	References.uiHandler.hoverCard = null
