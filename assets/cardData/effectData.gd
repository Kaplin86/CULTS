extends Resource
class_name EffectData

## A class for deciding what a card does

enum types {
	## When a effect is set to gain, it gives the target faction a specific follower type.
	GAIN, 
	## When a effect is set to steal, it removes a specific follower type from the target faction's pool and move it to the user's pool
	## There needs to be atleast 1 of that specific follower type for this effect to run.
	STEAL, 
	## When a effect is set to kill, it removes a specific follower type from the target faction's pool. That follower is added to the graveyard.
	## There needs to be atleast 1 of that specific follower type for this effect to run.
	KILL}

enum targetFactions {
	## The card user pool
	USER,
	## The civilian pool
	CIVILIANS,
	## A random enemy pool
	RANDOM_ENEMY,
	## A selected enemy pool
	SELECTED_ENEMY}

## Determines the type of effect.
@export var type : types = types.GAIN
## Determines the target group
@export var targetGroup : targetFactions = targetFactions.CIVILIANS
## Determines the target type
@export var targetType : References.figureTypes = References.figureTypes.ivory
## Determines the count
@export var count : int = 1
## Allows a requirement object to be attached
@export var requirement : EffectReq
