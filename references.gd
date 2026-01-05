extends Node

enum figureTypes {crimson,azure,ivory,amethyst,gold,chartreuse,amber}

var pullCards = ["boast","covet","hoard","idle","snatch","violence","brag","crave"]

var cultistVisual : Node3D = preload("res://scenes/cultistVisual.tscn").instantiate()
var boardHandler : boardHandlerNode  
var uiHandler : uiHandlerNode
var CardHandler : CardHandlerNode

var takenNames = []
