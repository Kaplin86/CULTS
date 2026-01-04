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

func getSelectedTarget() -> PlayerResource: ## Allows a choosing of an enemy. Random for CPUs.
	print("Choosing an enemy")
	if isUser:
		return References.boardHandler.playerObjects[1]
	else:
		var newPicker = References.boardHandler.playerObjects.duplicate()
		newPicker.erase(self)
		return newPicker.pick_random()
