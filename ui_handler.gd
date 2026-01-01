extends Control
class_name uiHandlerNode

var viewCards = false

func _ready() -> void:
	References.uiHandler = self


func _on_view_cards_mouse_entered() -> void:
	viewCards = true


func _on_view_cards_mouse_exited() -> void:
	viewCards = false
