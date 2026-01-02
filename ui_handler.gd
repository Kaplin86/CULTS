extends Control
class_name uiHandlerNode

var viewCards = false
var hoverCard = null
@onready var cardContainer : SidewaysUContainer = $ViewCards/Container

func _ready() -> void:
	References.uiHandler = self

func _process(_delta):
	if viewCards:
		$ViewCards.global_position.y = lerp($ViewCards.global_position.y,424.0,0.1)
		if Input.is_action_just_pressed("ui_left"):
			cardContainer.changeToIndex(cardContainer.getCurrentIndex() - 1)
		if Input.is_action_just_pressed("ui_right"):
			cardContainer.changeToIndex(cardContainer.getCurrentIndex() + 1)
	else:
		$ViewCards.global_position.y = lerp($ViewCards.global_position.y,532.0,0.1)

func _on_view_cards_mouse_entered() -> void:
	viewCards = true


func _on_view_cards_mouse_exited() -> void:
	viewCards = false


func _on_view_cards_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == false:
			if event.button_index in [1,2]:
				if hoverCard:
					print("activating")
			if event.button_index == 4:
				cardContainer.changeToIndex(cardContainer.getCurrentIndex() + 1)
			if event.button_index == 5:
				cardContainer.changeToIndex(cardContainer.getCurrentIndex() - 1)
