extends Node
class_name boardHandlerNode

var playerObjects : Array[PlayerResource] = [PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames)]

var boardFigures := {
	"crimson":43, 
	"azure":43,
	"ivory":43, 
	"amethyst":43,
	"gold":43,
	"chartreuse":43,
	"amber":43
}



var graveyardFigures := {}

var typeToColor := {
	"crimson":Color(0.385, 0.03, 0.117, 1.0), 
	"azure":Color(0.023, 0.193, 0.403, 1.0),
	"ivory":Color(0.865, 0.781, 0.781, 1.0), 
	"amethyst":Color(0.269, 0.001, 0.445, 1.0),
	"gold":Color(0.802, 0.691, 0.255, 1.0),
	"chartreuse":Color(0.098, 0.522, 0.231, 1.0),
	"amber":Color(0.641, 0.25, 0.0, 1.0)
}

var placedFigures = []

func getTotalBoardCount():
	var count = 0
	for type in boardFigures:
		count += boardFigures[type]
	return count

func renderNewBoard():
	for type in boardFigures:
		var count = boardFigures[type]
		for I in count:
			var newCultist = References.cultistVisual.duplicate()
			add_child(newCultist)
			var positionAngle = randf() * PI * 2
			var distance = randf() * 10
			newCultist.global_position = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance)
			newCultist.global_rotation.y = randf() * PI * 2
			newCultist.get_child(0).modulate = typeToColor[type]
			placedFigures.append(newCultist)

func changePoolCount(type,number):
	if boardFigures.has(type):
		boardFigures[type] += number
	else:
		boardFigures[type] = number
	if boardFigures[type] < 0: 
		boardFigures[type] = 0

func changeGraveyardPoolCount(type,number):
	if graveyardFigures.has(type):
		graveyardFigures[type] += number
	else:
		graveyardFigures[type] = number
	if graveyardFigures[type] < 0: 
		graveyardFigures[type] = 0

func getBoardCount():
	var total = 0
	for E in boardFigures.values():
		total += E
	return total

func resetBoard():
	boardFigures = {
	"crimson":43, 
	"azure":43,
	"ivory":43, 
	"amethyst":43,
	"gold":43,
	"chartreuse":43,
	"amber":43
	}
	graveyardFigures.clear()
	for E in playerObjects:
		E.pool.clear()
		E.cards.clear()

func _ready() -> void:
	References.boardHandler = self
	
	renderNewBoard()
	
		
	await get_tree().create_timer(1).timeout
	
	var winningCards = {}
	
	for I in 900:
		
		resetBoard()
		
		for E in playerObjects:
			var availablecards = References.CardHandler.loadedPull.values().duplicate()
			for i in 3:
				var selectedCard = availablecards.pick_random()
				E.cards.append(selectedCard)
				availablecards.erase(selectedCard)
		
		var boardFiguresLastTurn = boardFigures
		while getBoardCount() != 0:
			boardFiguresLastTurn = boardFigures.duplicate()
			
			for plyr in playerObjects:
				runTurn(plyr)
			
			if boardFigures == boardFiguresLastTurn:
				boardFigures = {"h":0}
		
		var largestPool = 0
		var largestPlayer : PlayerResource = null
		for e : PlayerResource in playerObjects:
			if e.getPoolCount() >= largestPool:
				largestPool = e.getPoolCount()
				largestPlayer = e
		for E in largestPlayer.cards:
			winningCards[E.card_name] = winningCards.get(E.card_name,0) + 1
	
	print(winningCards)

func runTurn(player :PlayerResource):
	var pips = randi_range(1,6)
	
	if player.isUser:
		print("bye.")
	else:
		var lowestCost = 6
		for CARD in player.cards:
			if CARD.pipCost <= lowestCost:
				lowestCost = CARD.pipCost
		
		while pips >= lowestCost:
			var availableCards : Array[CardData] = []
			for CARD in player.cards:
				if CARD.pipCost <= pips:
					availableCards.append(CARD)
			
			var usingCard : CardData = availableCards.pick_random()
			
			References.CardHandler.runCard(usingCard,player,pips)
			pips -= usingCard.pipCost
			pips = max(pips,0)
			#print("using card ", usingCard.card_name, " for ", usingCard.pipCost)
		
