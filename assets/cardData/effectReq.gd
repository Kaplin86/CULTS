extends Resource
class_name EffectReq

## A resource that determines when an effect is / can be ran


## If the player has pip count equal to the pip count req, the ability passes. -1 for n/a
@export var pipCountReq = -1
## When you have both have more and have more than set, if the player has more of the havemore type than the have more than, the ability passes.
@export var haveMore : References.figureTypes = -1
## When you have both have more and have more than set, if the player has more of the havemore type than the have more than, the ability passes.
@export var haveMoreThan : References.figureTypes = -1

## When you have both minType and minTypeCount, the player needs ATLEAST minTypeCount of mintype to run the effect.
@export var minType : References.figureTypes = -1
## When you have both minType and minTypeCount, the player needs ATLEAST minTypeCount of mintype to run the effect.
@export var minTypeCount = -1
