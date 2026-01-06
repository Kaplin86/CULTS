extends Control
@export var hoversize = 1.25
@export var cardData : CardData = null
@export var parentEffected = true


var velocityVis = Vector2(0.0,0.0)

func _process(_delta):
	if References.uiHandler.hoverCard == self:
		scale = lerp(scale,Vector2.ONE * hoversize,0.1)
	else:
		scale = lerp(scale,Vector2.ONE,0.1)
	
	global_position += velocityVis * _delta
	velocityVis.x = lerp(velocityVis.x,0.0,_delta)
	if velocityVis.x != 0.0:
		velocityVis.y += 16
	
	if global_position.y <= -180.0:
		if !References.boardHandler.usingCard:
			References.boardHandler.playerUsedCard(cardData)
		global_position.y = 1999
	
	return

func _ready():
	if cardData:
		tooltip_text = cardData.text_description

func _on_mouse_entered():
	References.uiHandler.hoverCard = self


func _on_mouse_exited():
	References.uiHandler.hoverCard = null
