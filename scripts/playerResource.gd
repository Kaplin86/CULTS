extends Resource
class_name PlayerResource

## This resource determines the data for the player. 

@export var isUser := false ## If true, the game will display the cards and allow the player to choose the action
@export var cards : Array[CardData] = [] ## An array of card data objects
@export var pool : Dictionary = {} ## The pool that contains different cultists by color.

var displayName = "" ## The player's display name, meant for non-user players. Randomly decided on runtime
var _displayNameChoices = ["Anthony","Amelia","Asher","Bruce","Beth","Beau","Chris","Cynthia","Cade"]

func _init(user := false, takenNames = []):
	isUser = user
	for Name in takenNames:
		_displayNameChoices.erase(Name)
	displayName = _displayNameChoices.pick_random()

	
	References.takenNames.append(displayName)

func changePoolCount(type,number): ## Changes the pool of a specific cultist type by number amount. Will create a new key if a specific type isn't already inside the player's pool
	if pool.has(type):
		pool[type] += number
	else:
		pool[type] = number
	if pool[type] < 0: 
		pool.erase(type)

func getPoolCount(): ## Gets the pool number / score of the player
	var total = 0
	for E in pool.values():
		total += E
	return total

func getSelectedTarget(running : PlayerResource,card : CardData = null) -> PlayerResource: ## Allows a choosing of an enemy. Random for CPUs.
	if isUser:
		References.boardHandler.userTargeting = true
		var targetNum : int = await References.uiHandler.chooseTarget
		References.boardHandler.userTargeting = false
		return References.boardHandler.playerObjects[targetNum]
	else:
		var playersArray = References.boardHandler.playerObjects.duplicate()
		playersArray.erase(self)
		var score = {}
		for plyr in playersArray:
			score[plyr] = 0
		
		for effect in card.effects:
			
			if effect.type == effect.types.STEAL or effect.type == effect.types.KILL:
				for plyr : PlayerResource in playersArray:
					var targetType = References.figureTypes.find_key(effect.targetType)
					score[plyr] += clamp(plyr.pool.get(targetType,0),0,effect.count)
		
		var highestScore = 0
		var highestPlayer = score.keys()[0]
		for player in score.keys():
			if score[player] >= highestScore:
				highestScore = score[player]
				highestPlayer = player
				
		return highestPlayer
