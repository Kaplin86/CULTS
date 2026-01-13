extends Control



var baseImage = """<image
  x="1295.24861" y="836.70659" transform="scale(0.16335,0.16335)" width="348" height="526"
  image-rendering="pixelated"
  href="data:image/png;base64,{{BODY_TEXT}}"
  xlink:href="data:image/png;base64,{{BODY_TEXT}}"
/>"""

func _ready():
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	makeNew()

func sanitizeDesc(desc):
	pass

func makeNew():
	var opening = FileAccess.open("uid://b3mgkb7hgru35", FileAccess.READ)
	var baseSVG = opening.get_as_text()
	opening.close()
	
	print(baseSVG)
	var actualImage : Image = $SubViewport.get_texture().get_image()
	var bytes : PackedByteArray = actualImage.save_png_to_buffer()
	var data : String = Marshalls.raw_to_base64(bytes)
	var newChunk = baseImage.replace("{{BODY_TEXT}}",data)
	print(newChunk)
	
	var newSVG = baseSVG.replace("<!-- TEXT_LAYER -->",newChunk)
	var newfile = FileAccess.open("D:/Downloads/new.svg",FileAccess.WRITE)
	newfile.store_string(newSVG)
	newfile.close()
