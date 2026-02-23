extends Node

enum figureTypes {crimson,azure,ivory,amethyst,gold,chartreuse,amber}

var pullCards = ["boast","covet","hoard","idle","snatch","harm","brag","crave","thief","consume","strengthen","yearn","feed","replace","glorify","laze","murder","deep_sleep","devour","indulge"]
var pushCards = ["drought","wildfire","hurricane","earthquake","flood","tornado","blizzard","curse"]

var cultistVisual : Node3D = preload("res://scenes/cultistVisual.tscn").instantiate()
var boardHandler : boardHandlerNode  
var uiHandler : uiHandlerNode
var CardHandler : CardHandlerNode

var takenNames = []

var typeToColor := {
	"crimson":Color(0.641, 0.25, 0.0, 1.0),
	"azure":Color(0.371, 0.626, 0.976, 1.0),
	"ivory":Color(0.865, 0.781, 0.781, 1.0), 
	"amethyst":Color("6229a9ff"),
	"gold":Color(0.802, 0.691, 0.255, 1.0),
	"chartreuse":Color("56df4cff"),
	"amber":Color(0.936, 0.203, 0.355, 1.0)
}

# vars
var PlayerCount = 5
var DiceCount = 1
var FollowerCount = 43
var CPUCount = 4
var CostForNewCard = 5
