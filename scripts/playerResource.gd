extends Resource
class_name PlayerResource

## This resource determines the data for the player. 

@export var isUser := false ## If true, the game will display the cards and allow the player to choose the action
@export var cards : Array[CardData] = [] ## An array of card data objects
@export var pool : Dictionary = {} ## The pool that contains different cultists by color.

func _init(user := false):
	isUser = user
