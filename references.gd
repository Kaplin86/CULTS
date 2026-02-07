extends Node

enum figureTypes {crimson,azure,ivory,amethyst,gold,chartreuse,amber}

var pullCards = ["boast","covet","hoard","idle","snatch","harm","brag","crave","thief","consume","strengthen","yearn","feed","replace","glorify","laze","murder","deep_sleep","devour","indulge"]
var pushCards = ["drought","wildfire","hurricane","earthquake","flood","tornado","blizzard","curse"]

var cultistVisual : Node3D = preload("res://scenes/cultistVisual.tscn").instantiate()
var boardHandler : boardHandlerNode  
var uiHandler : uiHandlerNode
var CardHandler : CardHandlerNode

var takenNames = []


# vars
var PlayerCount = 5
var DiceCount = 1
var FollowerCount = 43
var CPUCount = 4
var CostForNewCard = 5
