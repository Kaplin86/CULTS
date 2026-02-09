extends Node
class_name boardHandlerNode

var playerObjects : Array[PlayerResource] = []

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
	"crimson":Color(0.641, 0.25, 0.0, 1.0),
	"azure":Color(0.371, 0.626, 0.976, 1.0),
	"ivory":Color(0.865, 0.781, 0.781, 1.0), 
	"amethyst":Color("6229a9ff"),
	"gold":Color(0.802, 0.691, 0.255, 1.0),
	"chartreuse":Color("56df4cff"),
	"amber":Color(0.936, 0.203, 0.355, 1.0)
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

func moveCivToGrave(type : References.figureTypes, count = 1):
	var area = $"../Board/graveyard"
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
		newpos = Vector3(sin(positionAngle) * distance,$"../Board/graveyard".position.y,cos(positionAngle)* distance) + shape.global_position
		
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,120),0.25)
		newTween.tween_property(selectedCultist,"global_position",newpos,0.5)
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,0),0.25)
		
		placedFigures.get_or_add("grave",{}).get_or_add(References.figureTypes.find_key(type),[]).append(selectedCultist)
		selectedCultist.name = "cultist" + str(I)


func movePlayerToGrave(type : References.figureTypes,from : PlayerResource, count = 1):
	var area = $"../Board/graveyard"
	var shape = area.get_child(0)
	for I in min(count,placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).size()):
		print(I)
		var selectedCultist = placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).pick_random()
		placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).erase(selectedCultist)
		var newTween = create_tween()
		
		
		var newpos = Vector2(0,0)
		var positionAngle = randf() * PI * 1
		positionAngle += area.global_rotation.y
		var distance = shape.shape.radius *2 * distanceGrad.sample(randf())
		shape.global_position.y = 0
		newpos = Vector3(sin(positionAngle) * distance,$"../Board/graveyard".position.y,cos(positionAngle)* distance) + shape.global_position
		
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,120),0.25)
		newTween.tween_property(selectedCultist,"global_position",newpos,0.5)
		newTween.tween_property(selectedCultist.get_child(0),"offset",Vector2(0,0),0.25)
		
		placedFigures.get_or_add("grave",{}).get_or_add(References.figureTypes.find_key(type),[]).append(selectedCultist)
		selectedCultist.name = "cultist" + str(I)

func movePlayerToPlayer(type : References.figureTypes,from : PlayerResource,to : PlayerResource, count = 1):
	var num = playerObjects.find(to)
	var area = PlayerplayingAreas[num]
	var shape = area.get_child(0)
	print("plcaed figs is",placedFigures.get_or_add(from,{}), " looking for ", References.figureTypes.find_key(type))
	print("funne value is", placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).size())
	for I in min(count,placedFigures.get_or_add(from,{}).get_or_add(References.figureTypes.find_key(type),[]).size()):
		print(I)
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
	"crimson":References.FollowerCount, 
	"azure":References.FollowerCount,
	"ivory":References.FollowerCount, 
	"amethyst":References.FollowerCount,
	"gold":References.FollowerCount,
	"chartreuse":References.FollowerCount,
	"amber":References.FollowerCount
	}
	graveyardFigures.clear()
	playerObjects.clear()
	var cpus = References.CPUCount
	print("cpu count is", cpus)
	for I in References.PlayerCount - cpus:
		playerObjects.append(PlayerResource.new(true,References.takenNames))
	for I in cpus:
		playerObjects.append(PlayerResource.new(false,References.takenNames))


var queueAnims = []


func parseQueuedAnims():
	print(queueAnims)
	for I in queueAnims:
		if I.get("type","n/a") == "CTP":
			moveCivToPlayer(I.get("follower","n/a"),I.get("plyr"),I.get("count",1))
		if I.get("type","n/a") == "PTP":
			movePlayerToPlayer(I.get("follower","n/a"),I.get("plyr1"),I.get("plyr2"),I.get("count",1))
		if I.get("type","n/a") == "CTG":
			moveCivToGrave(I.get("follower","n/a"),I.get("count",1))
		if I.get("type","n/a") == "PTG":
			movePlayerToGrave(I.get("follower","n/a"),I.get("plyr"),I.get("count",1))
	queueAnims.clear()
	
	for I in $"../PlayerSprites".get_children():
		for E in I.get_children():
			E.queue_free()
		
		var plyrnum = $"../PlayerSprites".get_children().find(I)
		var cardCount = playerObjects[plyrnum].cards.size()
		print("the card count for ", playerObjects[plyrnum].displayName, " is ", cardCount)
		var boundingDist = 0.11
		for num in cardCount:
			var boundingPoint = lerp(boundingDist * -1,boundingDist,(num + 1)/float(cardCount))
			var newcard = Sprite3D.new()
			newcard.texture = load("res://assets/cards/blank.svg")
			I.add_child(newcard)
			newcard.position = Vector3(boundingPoint,-0.038,1.13)
			newcard.rotation_degrees = Vector3(0,180,0)
			newcard.scale = Vector3(0.008,0.008,0.008)
			newcard.render_priority = -1

func addCardsFromPool(pool,cardsToAppend,count):
	var availablecards = pool
	for i in count:
		var selectedCard = availablecards.pick_random()
		cardsToAppend.append(selectedCard)
		availablecards.erase(selectedCard)

func _ready() -> void:
	References.boardHandler = self
	resetBoard()
	renderNewBoard()
	
	
	#await get_tree().create_timer(1).timeout
	
	#simGames()
	
	await get_tree().create_timer(1).timeout
	
	for E in playerObjects:		
		addCardsFromPool(References.CardHandler.loadedPull.values(),E.cards,1)
		addCardsFromPool(References.CardHandler.loadedPush.values(),E.cards,1)
		
	
	
	
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


func sortPlayerByMostFollowers():
	var sortDictionary = {}
	var sortedList = []
	for I in playerObjects:
		var PieceCount = I.getPoolCount() + (0.001 * playerObjects.find(I))
		sortDictionary[PieceCount] = I 
	var order = sortDictionary.keys()
	order.sort()
	order.reverse()
	for I in order:
		sortedList.append(sortDictionary[I])
	return sortedList

func calculateOddsForNewCard(placement,playerCount):
	return (cos(placement * (PI/ ((playerCount - 1)/2)  ) ) * 0.3) + 0.5

var currentPlayerPips = 0
var currentPlayer = null

var userTargeting = false

func runTurn(player :PlayerResource, anim = true):
	queueAnims.clear()
	currentPlayerPips = randi_range(1,6 * References.DiceCount)
	currentPlayer = player
	
	References.uiHandler.showPlayerTurn(player)
	
	if player.isUser:
		References.uiHandler.addCardsForUser(player)
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
		
		var currentRanking = sortPlayerByMostFollowers()
		print("My Placement is ",  sortPlayerByMostFollowers().find(player) + 1, "#")
		var oddsToUseCard = calculateOddsForNewCard(currentRanking.find(player),playerObjects.size())
		print("I am ", player.displayName, " and my odds are ", oddsToUseCard)
		if randf() <= oddsToUseCard:
			print("ok trying to get a new card")
			# this is the part where they get the extra card
			var usableTypes = []
			for I in player.pool:
				print("thinking of ", I, " which has a value of ", player.pool[I])
				if player.pool[I] >= References.CostForNewCard:
					print("goodie!")
					usableTypes.append(I)
			
			if usableTypes != []:
				if References.CardHandler.loadedPull.size() and References.CardHandler.loadedPull.size() != 0:
					var chosenType = usableTypes.pick_random()
					
					var newCount = References.CostForNewCard
					player.changePoolCount(chosenType,newCount * -1)
					References.boardHandler.changeGraveyardPoolCount(chosenType,newCount)
					References.boardHandler.queueAnims.append({"type":"PTG","follower":References.figureTypes.get(chosenType),"plyr":player,"count":newCount})
					
					var chosenCardType = ["pull","push"].pick_random()
					if chosenCardType == "pull":
						addCardsFromPool(References.CardHandler.loadedPull.values(),player.cards,1)
					elif chosenCardType == "push":
						addCardsFromPool(References.CardHandler.loadedPush.values(),player.cards,1)
					
				parseQueuedAnims()
				await get_tree().create_timer(1).timeout

var usingCard = false

func animatedCardSegment(carddata : CardData, state : int = -1):
	
	$"../BigCard".texture = load("res://assets/cards/" + carddata.card_name + ".svg")
	
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
	
	var cardSelectionTime =get_tree().create_timer(999)
	
	
	await References.CardHandler.runCard(cardData,currentPlayer,currentPlayerPips)
	
	print("runtime",999.0 - cardSelectionTime.time_left )
	
	if 999.0 - cardSelectionTime.time_left < 0.25:
		await get_tree().create_timer(2).timeout
	
	currentPlayerPips -= cardData.pipCost + cardData.consumeExtraPips
	currentPlayerPips = max(currentPlayerPips,0)
	References.uiHandler.displayPips(currentPlayerPips)
	
	await animatedCardSegment(cardData,1)
	usingCard = false
