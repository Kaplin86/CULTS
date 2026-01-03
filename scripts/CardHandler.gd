extends Node
class_name CardHandlerNode

func _ready():
	References.CardHandler = self

func runCard(data : CardData,player : PlayerResource):
	print(data)
