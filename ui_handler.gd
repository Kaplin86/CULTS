extends Control
class_name uiHandlerNode

var viewCards = false
var hoverCard = null
@onready var cardContainer : SidewaysUContainer = $ViewCards/Container
var dragging = false
var draggingOffset = Vector2.ZERO
var draggingCard = null

var selectorButtons = []

signal turnEnded
signal chooseTarget(targetNum : int)

func _ready() -> void:
	References.uiHandler = self
	displayPips(14)

func _process(_delta):
	if viewCards:
		$ViewCards.global_position.y = lerp($ViewCards.global_position.y,424.0,0.1)
		if Input.is_action_just_pressed("ui_left"):
			cardContainer.changeToIndex(cardContainer.getCurrentIndex() - 1)
		if Input.is_action_just_pressed("ui_right"):
			cardContainer.changeToIndex(cardContainer.getCurrentIndex() + 1)
	else:
		if References.boardHandler.get("currentPlayer"):
			if References.boardHandler.currentPlayer.isUser:
				$ViewCards.global_position.y = lerp($ViewCards.global_position.y,532.0,0.1)
			else:
				$ViewCards.global_position.y = lerp($ViewCards.global_position.y,902.0,0.1)
		else:
			$ViewCards.global_position.y = lerp($ViewCards.global_position.y,532.0,0.1)
	
	if dragging:
		draggingCard.global_position = draggingOffset + get_global_mouse_position() 
	
	
	if $"../BigCard":
		$"../BigCard".rotation.y += _delta * 3
		
	if References.boardHandler.currentPlayer:
		if !References.boardHandler.currentPlayer.isUser:
			viewCards = false
	
	if selectorButtons.size() != References.boardHandler.playerObjects.size():
		for I in selectorButtons:
			I.queue_free()
		selectorButtons.clear()
		for I in References.boardHandler.playerObjects.size():
			var newbutton = Button.new()
			selectorButtons.append(newbutton)
			newbutton.text = "Target"
			add_child(newbutton)
			newbutton.pressed.connect(chooseTarget.emit.bind(I))
	
	for button in selectorButtons:
		if References.boardHandler.playerObjects[selectorButtons.find(button)] == References.boardHandler.currentPlayer:
			button.visible = false
		elif !References.boardHandler.userTargeting:
			button.visible = false
		else:
			button.visible = true
		targetButtonMove(selectorButtons.find(button),button)
	
func targetButtonMove(areaNum : int,button : Button):
	var currentCam : Camera3D = get_viewport().get_camera_3d()
	
	var boardArea = get_node("../Board/plyr"  + str(areaNum + 1))
	var wantedPos = boardArea.global_position
	var dist = boardArea.get_child(0).shape.radius
	wantedPos.x += dist * sin(boardArea.get_child(0).global_rotation.y + deg_to_rad(90))
	wantedPos.z += dist * cos(boardArea.get_child(0).global_rotation.y + deg_to_rad(90))
	
	
	wantedPos += Vector3(0,1,0)
	var PositionOnCamera = currentCam.unproject_position(wantedPos)
	var buttonPosition = PositionOnCamera - (button.size / 2)
	button.position = buttonPosition
	
	

func _on_view_cards_mouse_entered() -> void:
	if References.boardHandler.currentPlayer:
		if References.boardHandler.currentPlayer.isUser:
			viewCards = true


func _on_view_cards_mouse_exited() -> void:
	viewCards = false


var lastMouseVel = Vector2(0.0,0.0)

func _on_view_cards_gui_input(event):
	if event is InputEventMouseMotion:
		lastMouseVel = event.velocity
	if event is InputEventMouseButton:
		if event.pressed == true:
			if event.button_index in [1,2]:
				if hoverCard:
					if hoverCard.cardData != null:
						if hoverCard.cardData.pipCost <= References.boardHandler.currentPlayerPips:
							dragging = true
							draggingCard = hoverCard
							draggingCard.velocityVis = Vector2.ZERO
							draggingOffset = draggingCard.global_position - get_global_mouse_position()
							hoverCard.parentEffected = false
					
		if event.pressed == false:
			if event.button_index in [1,2]:
				if dragging:
					print("cancel dragging")
					draggingCard.parentEffected = true
					draggingCard.velocityVis = lastMouseVel
					draggingCard = null
					dragging = false
					
			if event.button_index == 4:
				cardContainer.changeToIndex(cardContainer.getCurrentIndex() + 1)
			if event.button_index == 5:
				cardContainer.changeToIndex(cardContainer.getCurrentIndex() - 1)


func _on_end_turn_pressed():
	turnEnded.emit()

var diceClones = []

func displayPips(num):
	for I in diceClones:
		I.queue_free()
	diceClones.clear()
	
	for I in $ViewCards/Container.get_children():
		if I.cardData != null:
			if I.cardData.pipCost <= num:
				I.modulate = Color(1.0, 1.0, 1.0, 1.0)
			else:
				I.modulate = Color(0.49, 0.49, 0.49, 1.0)
	
	
	var first = clamp(num,0,6)
	$ViewCards/Dice.texture = load("res://assets/dice/"+str(first)+".svg")
	num -= first
	var index = 0
	while num > 0:
		index += 1
		var diceClone = $ViewCards/Dice.duplicate()
		diceClones.append(diceClone)
		$ViewCards/Dice.add_sibling(diceClone)
		diceClone.global_position.x = $ViewCards/Dice.global_position.x + (55 * index)
		var val = clamp(num,0,6)
		diceClone.texture = load("res://assets/dice/"+str(val)+".svg")
		num -= val
	
func showPlayerTurn(playerObject : PlayerResource):
	if playerObject.isUser:
		for I in References.boardHandler.playerObjects:
			if I.isUser and I != playerObject:
				$PlayerIndicator.text = "PLAYER: #" + str(References.boardHandler.playerObjects.find(playerObject) + 1)
				return
		$PlayerIndicator.text = "PLAYER: YOU"
	else:
		$PlayerIndicator.text = "PLAYER: " + playerObject.displayName
