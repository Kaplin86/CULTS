extends Node
class_name CardHandlerNode

var loadedPull = {}

func _ready():
	References.CardHandler = self
	for pullName in References.pullCards:
		loadedPull[pullName] = ResourceLoader.load("res://assets/cardData/"+pullName+".tres")

func runCard(data : CardData,player : PlayerResource, currentPips = 0):
	
	var selected_target : PlayerResource = null
	
	for effectChunk : EffectData in data.effects:
		if effectChunk.targetGroup == effectChunk.targetFactions.SELECTED_ENEMY and selected_target == null:
			selected_target = player.getSelectedTarget(player,data)
			
	
	for effectChunk : EffectData in data.effects:
		var cultistType = References.figureTypes.find_key(effectChunk.targetType)
		
		if effectChunk.requirement != null:
			if effectChunk.requirement.pipCountReq != -1:
				if effectChunk.requirement.pipCountReq != currentPips:
					continue
			if effectChunk.requirement.haveMore != -1 and effectChunk.requirement.haveMoreThan != -1:
				var count1 = player.pool[References.figureTypes.find_key(effectChunk.requirement.haveMore)]
				var count2 = player.pool[References.figureTypes.find_key(effectChunk.requirement.haveMoreThan)]
				if count1 < count2:
					continue
			
		
		if effectChunk.type == effectChunk.types.GAIN:
			if effectChunk.targetGroup == effectChunk.targetFactions.USER:
				player.changePoolCount(cultistType,effectChunk.count)
			
			if effectChunk.targetGroup == effectChunk.targetFactions.CIVILIANS:
				References.boardHandler.changePoolCount(cultistType,effectChunk.count)
			
			if effectChunk.targetGroup == effectChunk.targetFactions.SELECTED_ENEMY:
				selected_target.changePoolCount(cultistType,effectChunk.count)
		
		if effectChunk.type == effectChunk.types.STEAL:
			if effectChunk.targetGroup == effectChunk.targetFactions.SELECTED_ENEMY:
				var newCount = clamp( selected_target.pool.get(cultistType,0) ,0,effectChunk.count)
				selected_target.changePoolCount(cultistType,newCount * -1)
				player.changePoolCount(cultistType,newCount)
			
			if effectChunk.targetGroup == effectChunk.targetFactions.CIVILIANS:
				var newCount = clamp( References.boardHandler.boardFigures.get(cultistType,0) ,0,effectChunk.count)
				References.boardHandler.changePoolCount(cultistType,newCount * -1)
				player.changePoolCount(cultistType,newCount * 1)
		
		if effectChunk.type == effectChunk.types.KILL:
			if effectChunk.targetGroup == effectChunk.targetFactions.USER:
				var newCount = clamp( player.pool.get(cultistType,0) ,0,effectChunk.count)
				player.changePoolCount(cultistType,newCount * -1)
				References.boardHandler.changeGraveyardPoolCount(cultistType,newCount)
				
			if effectChunk.targetGroup == effectChunk.targetFactions.CIVILIANS:
				var newCount = clamp( References.boardHandler.boardFigures.get(cultistType,0) ,0,effectChunk.count)
				References.boardHandler.changePoolCount(cultistType,newCount * -1)
				References.boardHandler.changeGraveyardPoolCount(cultistType,newCount)
			
			if effectChunk.targetGroup == effectChunk.targetFactions.SELECTED_ENEMY:
				var newCount = clamp( selected_target.pool.get(cultistType,0) ,0,effectChunk.count) 
				selected_target.changePoolCount(cultistType,newCount * -1)
				References.boardHandler.changeGraveyardPoolCount(cultistType,newCount)
