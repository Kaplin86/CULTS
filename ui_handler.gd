extends Control
class_name uiHandlerNode

var viewCards = false
var hoverCard = null

func _ready() -> void:
	References.uiHandler = self

func _process(_delta):
	if viewCards:
		$ViewCards.global_position.y = lerp($ViewCards.global_position.y,424.0,0.1)
	else:
		$ViewCards.global_position.y = lerp($ViewCards.global_position.y,532.0,0.1)

func _on_view_cards_mouse_entered() -> void:
	viewCards = true


func _on_view_cards_mouse_exited() -> void:
	viewCards = false
