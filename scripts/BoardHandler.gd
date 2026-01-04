extends Node
class_name boardHandlerNode

var playerObjects : Array[PlayerResource] = [PlayerResource.new(false),PlayerResource.new(true,References.takenNames),PlayerResource.new(true,References.takenNames),PlayerResource.new(true,References.takenNames),PlayerResource.new(true,References.takenNames)]

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

func _ready() -> void:
	References.boardHandler = self
	print(getTotalBoardCount())
	renderNewBoard()
	for E in playerObjects:
		print(E, " is ",E.displayName)
