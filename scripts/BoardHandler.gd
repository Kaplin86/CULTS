extends Node
class_name boardHandlerNode

var playerObjects : Array[PlayerResource] = [PlayerResource.new(true,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames),PlayerResource.new(false,References.takenNames)]

@export var MainArea : Area3D
@export var PlayerplayingAreas : Array[Area3D] = []

@export var distanceGrad : Curve = null

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
	"crimson":Color(0.936, 0.203, 0.355, 1.0), 
	"azure":Color(0.371, 0.626, 0.976, 1.0),
	"ivory":Color(0.865, 0.781, 0.781, 1.0), 
	"amethyst":Color("6229a9ff"),
	"gold":Color(0.802, 0.691, 0.255, 1.0),
	"chartreuse":Color("56df4cff"),
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
			var distance = MainArea.get_child(0).shape.radius * distanceGrad.sample(randf())*2
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
				var distance = shape.shape.radius * distanceGrad.sample(randf())*2
				shape.global_position.y = 0
				newCultist.global_position = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance) + shape.global_position
				newCultist.global_rotation.y = randf() * PI * 2
				newCultist.get_child(0).modulate = typeToColor[type]
					
				placedFigures.get_or_add(plyr,{}).get_or_add(type,[]).append(newCultist)

func moveCivToPlayer(type : References.figureTypes,player : PlayerResource, count = 1):
	var num = playerObjects.find(player)
	var area = PlayerplayingAreas[num]
	var shape = area.get_child(0)
	for I in min(count,placedFigures.get_or_add("civ",{}).get_or_add(References.figureTypes.find_key(type),[]).size()):
		var selectedCultist = placedFigures.get_or_add("civ",{}).get_or_add(References.figureTypes.find_key(type),[]).pick_random()
		placedFigures.get_or_add("civ",{}).get_or_add(References.figureTypes.find_key(type),[]).erase(selectedCultist)
		var newTween = create_tween()
		
		
		var newpos = Vector2(0,0)
		var positionAngle = randf() * PI * 1
		positionAngle += area.global_rotation.y
		var distance = shape.shape.radius *2 * distanceGrad.sample(randf())
		shape.global_position.y = 0
		newpos = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance) + shape.global_position
		
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,120),0.25)
		newTween.tween_property(selectedCultist,"global_position",newpos,0.5)
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,0),0.25)
		
		placedFigures.get_or_add(player,{}).get_or_add(References.figureTypes.find_key(type),[]).append(selectedCultist)
		selectedCultist.name = "cultist" + str(I)

func movePlayerToPlayer(type : References.figureTypes,from : PlayerResource,to : PlayerResource, count = 1):
	var num = playerObjects.find(to)
	var area = PlayerplayingAreas[num]
	var shape = area.get_child(0)
	for I in min(count,placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).size()):
		var selectedCultist = placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).pick_random()
		placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).erase(selectedCultist)
		var newTween = create_tween()
		
		
		var newpos = Vector2(0,0)
		var positionAngle = randf() * PI * 1
		positionAngle += area.global_rotation.y
		var distance = shape.shape.radius *2 * distanceGrad.sample(randf())
		shape.global_position.y = 0
		newpos = Vector3(sin(positionAngle) * distance,0,cos(positionAngle)* distance) + shape.global_position
		
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,120),0.25)
		newTween.tween_property(selectedCultist,"global_position",newpos,0.5)
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,0),0.25)
		
		placedFigures.get_or_add(to,{}).get_or_add(References.figureTypes.find_key(type),[]).append(selectedCultist)
		selectedCultist.name = "cultist" + str(I)

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


var queueAnims = []


func parseQueuedAnims():
	for I in queueAnims:
		if I.get("type","n/a") == "CTP":
			moveCivToPlayer(I.get("follower","n/a"),I.get("plyr"),I.get("count",1))
		if I.get("type","n/a") == "PTP":
			movePlayerToPlayer(I.get("follower","n/a"),I.get("plyr1"),I.get("plyr2"),I.get("count",1))
	queueAnims.clear()

func _ready() -> void:
	References.boardHandler = self
	
	renderNewBoard()
	
	
	#await get_tree().create_timer(1).timeout
	
	#simGames()
	
	await get_tree().create_timer(1).timeout
	
	for E in playerObjects:
		var availablecards = References.CardHandler.loadedPull.values().duplicate()
		for i in 3:
			var selectedCard = availablecards.pick_random()
			E.cards.append(selectedCard)
			availablecards.erase(selectedCard)
	
	while getBoardCount() != 0:
		for plyr in playerObjects:
			print("turn", plyr)
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
						runTurn(plyr,false)
					
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

var userTargeting = false

func runTurn(player :PlayerResource, anim = true):
	queueAnims.clear()
	currentPlayerPips = randi_range(1,6)
	currentPlayer = player
	
	References.uiHandler.showPlayerTurn(player)
	
	if player.isUser:
		References.uiHandler.displayPips(currentPlayerPips)
		await References.uiHandler.turnEnded
	else:
		var lowestCost = 6
		for CARD in player.cards:
			if CARD.pipCost <= lowestCost:
				lowestCost = CARD.pipCost
		

		while currentPlayerPips >= lowestCost:
			var availableCards : Array[CardData] = []
			for CARD in player.cards:
				if CARD.pipCost <= currentPlayerPips:
					availableCards.append(CARD)
			
			var ChosenCard : CardData = availableCards.pick_random()
			
			References.CardHandler.runCard(ChosenCard,player,currentPlayerPips)
			currentPlayerPips -= ChosenCard.pipCost + ChosenCard.consumeExtraPips
			currentPlayerPips = max(currentPlayerPips,0)
			
			if anim:
				await animatedCardSegment(ChosenCard)
			
			#print("using card ", usingCard.card_name, " for ", usingCard.pipCost)
		

var usingCard = false

func animatedCardSegment(carddata : CardData, state : int = -1):
	if state in [-1,0]:
		$"../BigCard/AnimationPlayer".play("fall")
	
	if state in [-1]:
		await get_tree().create_timer(2).timeout
	
	if state in [-1,1]:
		parseQueuedAnims()
		
		$"../BigCard/AnimationPlayer".play("up")
		await get_tree().create_timer(1).timeout

func playerUsedCard(cardData : CardData):
	print("got card")
	usingCard = true
	
	await animatedCardSegment(cardData,0)
	
	await References.CardHandler.runCard(cardData,currentPlayer,currentPlayerPips)
	
	currentPlayerPips -= cardData.pipCost + cardData.consumeExtraPips
	currentPlayerPips = max(currentPlayerPips,0)
	References.uiHandler.displayPips(currentPlayerPips)
	
	await animatedCardSegment(cardData,1)
	usingCard = false
