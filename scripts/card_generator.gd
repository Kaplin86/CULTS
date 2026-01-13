extends Control

var boardRef = boardHandlerNode.new()

var baseImage = """<image
  x="1295.24861" y="836.70659" transform="scale(0.16335,0.16335)" width="348" height="526"
  image-rendering="pixelated"
  href="data:image/png;base64,{{BODY_TEXT}}"
  xlink:href="data:image/png;base64,{{BODY_TEXT}}"
/>"""

func _ready():
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	$Text/desc.parse_bbcode(sanitizeDesc($Text/desc.text))
	makeNew()
	
	
	var font : FontFile= $Text/desc.get_theme_font("font")
	var longestDesc = "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
	for I : CardData in References.CardHandler.loadedPull.values():
		if font.get_string_size(I.text_description).x < font.get_string_size(longestDesc).x:
			longestDesc = I.text_description
	print(longestDesc)
	



func sanitizeDesc(desc):
	var newstring = desc
	for I : String in boardRef.typeToColor.keys():
		var newimgtag = "[img=50 color='COLORCODE']uid://cumki28o8ssgk[/img]".replace("COLORCODE",boardRef.typeToColor[I].to_html())
		newstring = newstring.replace(I.to_upper(),newimgtag)
	return newstring

func makeNew():
	var opening = FileAccess.open("uid://b3mgkb7hgru35", FileAccess.READ)
	var baseSVG = opening.get_as_text()
	opening.close()
	
	var actualImage : Image = $SubViewport.get_texture().get_image()
	var bytes : PackedByteArray = actualImage.save_png_to_buffer()
	var data : String = Marshalls.raw_to_base64(bytes)
	var newChunk = baseImage.replace("{{BODY_TEXT}}",data)
	
	var newSVG = baseSVG.replace("<!-- TEXT_LAYER -->",newChunk)
	var newfile = FileAccess.open("D:/Downloads/new.svg",FileAccess.WRITE)
	newfile.store_string(newSVG)
	newfile.close()
