extends CanvasLayer

var untagged = []
var todo = []
var dt = 0.0
func _process(delta):
	
	dt += delta
	
	if todo == []:
		todo = $Node2D/TileMapLayer.get_used_cells()
	
	if dt <= 0.5:
		return
	
	for I : Vector2i in todo:
		if not I in untagged:
			untagged.append(I)
			todo.erase(I)
			var pos = I + Vector2i(randi_range(-1,1),randi_range(-1,1))
			$Node2D/TileMapLayer.set_cell(pos,0,Vector2i(0,0),0)
			todo.append(pos)
			
			pos = I + Vector2i(randi_range(-1,1),randi_range(-1,1))
			$Node2D/TileMapLayer.set_cell(pos,0,Vector2i(0,0),0)
			todo.append(pos)
			
			pos = I + Vector2i(randi_range(-1,1),randi_range(-1,1))
			$Node2D/TileMapLayer.set_cell(pos,0,Vector2i(0,0),0)
			todo.append(pos)
			
			pos = I + Vector2i(randi_range(-1,1),randi_range(-1,1))
			$Node2D/TileMapLayer.set_cell(pos,0,Vector2i(0,0),0)
			todo.append(pos)
		
		#for X in 3:
		#	for Y in 3:
		#		print(X - 1,Y - 1)
