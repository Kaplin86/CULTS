extends Node
class_name boardHandlerNode

var playerObjects : Array[PlayerResource] = [PlayerResource.new(true,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames)]

@export var MainArea : Area3D
@export var PlayerplayingAreas : Array[Area3D] = []

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



func getTotalBoardCount():
	var count = 0
	for type in boardFigures:
		count += boardFigures[type]
	return count

var placedFigures = {"civ":{}}

func renderNewBoard():
	
	for type in References.figureTypes:
		var count = boardFigures[type]
		for I in count - placedFigures.get(type,[]).size():
			var newCultist = References.cultistVisual.duplicate()
			add_child(newCultist)
			var positionAngle = randf() * PI * 2
			var distance = MainArea.get_child(0).shape.radius * randf()*2
			MainArea.get_child(0).global_position.y = 0
			newCultist.global_position = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance) + MainArea.get_child(0).global_position
			newCultist.global_rotation.y = randf() * PI * 2
			newCultist.get_child(0).modulate = typeToColor[type]
			if placedFigures["civ"].has(type):
				placedFigures["civ"][type].append(newCultist)
			else:
				placedFigures["civ"][type] = [newCultist]
	
	var num = -1
	for plyr in playerObjects:
		num += 1
		var area = PlayerplayingAreas[num]
		var shape = area.get_child(0)
		for type in plyr.pool:
			var count = plyr.pool[type]
			print(plyr, " has ", plyr.pool)
			for I in count - placedFigures[plyr].get(type,[]).size() :
				var newCultist = References.cultistVisual.duplicate()
				add_child(newCultist)
				var positionAngle = randf() * PI * 1
				positionAngle += area.global_rotation.y
				var distance = shape.shape.radius * randf()*2
				shape.global_position.y = 0
				newCultist.global_position = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance) + shape.global_position
				newCultist.global_rotation.y = randf() * PI * 2
				newCultist.get_child(0).modulate = typeToColor[type]
					
				placedFigures.get_or_add(plyr,{}).get_or_add(type,[]).append(newCultist)

func moveCivToPlayer(type : References.figureTypes,player : PlayerResource, count = 1):
	var num = playerObjects.find(player)
	var area = PlayerplayingAreas[num]
	var shape = area.get_child(0)
	for I in count:
		var selectedCultist = placedFigures.get_or_add("civ",{}).get_or_add(References.figureTypes.find_key(type),[]).pick_random()
		selectedCultist.global_position.y += 10

func movePlayerToPlayer():
	pass

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
	
	
	await get_tree().create_timer(0).timeout
	
	moveCivToPlayer(References.figureTypes.crimson,playerObjects[0])
	
	while getBoardCount() != 0:
		for plyr in playerObjects:
			await runTurn(plyr)


func simGames():
	var overallwinning = {}
	
	for plyrCount in [2,3,4,5,6]:
		playerObjects= []
		for i in plyrCount:
			playerObjects.append(PlayerResource.new(false,[]))
		
		for count in 5:
			var winningCards = {}
			for I in 300:
				resetBoard()
				
				for E in playerObjects:
					var availablecards = References.CardHandler.loadedPull.values().duplicate()
					for i in count + 1:
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
			overallwinning[Vector2(count + 1,plyrCount)] = winningCards
	print(overallwinning)


var currentPlayerPips = 0
var currentPlayer = null
func runTurn(player :PlayerResource):
	currentPlayerPips = randi_range(1,6)
	currentPlayer = player
	
	if player.isUser:
		References.uiHandler.displayPips(currentPlayerPips)
		await References.uiHandler.turnEnded
	else:
		var lowestCost = 7
		for CARD in player.cards:
			if CARD.pipCost <= lowestCost:
				lowestCost = CARD.pipCost
		
		
		
		while currentPlayerPips >= lowestCost:
			var availableCards : Array[CardData] = []
			for CARD in player.cards:
				if CARD.pipCost <= currentPlayerPips:
					availableCards.append(CARD)
			
			var usingCard : CardData = availableCards.pick_random()
			
			References.CardHandler.runCard(usingCard,player,currentPlayerPips)
			currentPlayerPips -= usingCard.pipCost + usingCard.consumeExtraPips
			currentPlayerPips = max(currentPlayerPips,0)
			#print("using card ", usingCard.card_name, " for ", usingCard.pipCost)
		

var usingCard = false

func playerUsedCard(cardData : CardData):
	print("got card")
	usingCard = true
	
	References.CardHandler.runCard(cardData,currentPlayer,currentPlayerPips)
	
	currentPlayerPips -= cardData.pipCost + cardData.consumeExtraPips
	currentPlayerPips = max(currentPlayerPips,0)
	References.uiHandler.displayPips(currentPlayerPips)
	
	await get_tree().create_timer(1).timeout
	usingCard = false
