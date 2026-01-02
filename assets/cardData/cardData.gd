extends Resource
class_name CardData

## A resource that determines the data for cards

@export var card_name : String = "snatch" ## Determines the internal and display name for the card
@export var text_description : String = "STEAL 1 IVORY FOLLOWER" ## The display description for hover texts
@export var pipCost : int = 2 ## A integer referring to the pips required
@export var effects : Array[EffectData] = [] ## An array of [EffectData] objects
