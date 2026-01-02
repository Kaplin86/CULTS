extends Control
@export var hoversize = 1.25
@export var cardData : CardData = null

func _process(delta):
	if References.uiHandler.hoverCard == self:
		scale = lerp(scale,Vector2.ONE * hoversize,0.1)
	else:
		scale = lerp(scale,Vector2.ONE,0.1)
	
	return


func _on_mouse_entered():
	References.uiHandler.hoverCard = self


func _on_mouse_exited():
	References.uiHandler.hoverCard = null
