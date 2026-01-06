extends Node

enum figureTypes {crimson,azure,ivory,amethyst,gold,chartreuse,amber}

var pullCards = ["boast","covet","hoard","idle","snatch","harm","brag","crave","thief","consume","strengthen","yearn","feed","replace","glorify","laze","murder","deep_sleep","devour","indulge"]

var cultistVisual : Node3D = preload("res://scenes/cultistVisual.tscn").instantiate()
var boardHandler : boardHandlerNode  
var uiHandler : uiHandlerNode
var CardHandler : CardHandlerNode

var takenNames = []
