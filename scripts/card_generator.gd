extends Control

var boardRef = boardHandlerNode.new()

var baseImage = """<image
  x="1295.24861" y="836.70659" transform="scale(0.16335,0.16335)" width="348" height="526"
  image-rendering="pixelated"
  href="data:image/png;base64,{{BODY_TEXT}}"
  xlink:href="data:image/png;base64,{{BODY_TEXT}}"
/>"""

var onepip = """
<g stroke-width="0.5" stroke-linecap="butt"><path d="M254.81153,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/><path d="M256.28659,149.82348c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/></g>"""

var twopip = """
<g stroke-width="0.5" stroke-linecap="butt">
            <path d="M254.81152,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/>
            <path d="M258.96389,146.92135c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/>
            <path d="M253.42094,152.78767c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/>
        </g>
"""

var threepip = """
	<g stroke-width="0.5" stroke-linecap="butt"><path d="M254.81153,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/><path d="M258.96389,146.92135c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42095,152.78767c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M256.24196,149.86812c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/></g>
"""

var fourpip = """
<g stroke-width="0.5" stroke-linecap="butt"><path d="M254.81153,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/><path d="M258.96389,146.92135c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42095,152.78767c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42992,147.05608c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M258.69773,152.68098c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/></g>"""

var fifthpip = """
<g stroke-width="0.5" stroke-linecap="butt"><path d="M254.81153,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/><path d="M258.96389,146.92135c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42095,152.78767c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42992,147.05608c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M258.96555,152.81488c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M256.24196,149.91275c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/></g>"""

var sixthpip = """
<g stroke-width="0.5" stroke-linecap="butt"><path d="M254.81153,154.91303c-1.38071,0 -2.5,-1.11929 -2.5,-2.5v-5.21214c0,-1.38071 1.11929,-2.5 2.5,-2.5h5.21214c1.38071,0 2.5,1.11929 2.5,2.5v5.21214c0,1.38071 -1.11929,2.5 -2.5,2.5z" fill="#ffffff" stroke="#f3f3f3"/><path d="M258.96389,146.92135c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42095,152.78767c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.42992,147.05608c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M258.96555,152.81488c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M259.09863,149.82348c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/><path d="M253.52002,149.86894c0,-0.69036 0.55964,-1.25 1.25,-1.25c0.69036,0 1.25,0.55964 1.25,1.25c0,0.69036 -0.55964,1.25 -1.25,1.25c-0.69036,0 -1.25,-0.55964 -1.25,-1.25z" fill="#000000" stroke="none"/></g>"""

func _ready():
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	$Text/desc.parse_bbcode(sanitizeDesc($Text/desc.text))
	
	
var typeToColor := {
	"crimson":Color("943C29"),
	"azure":Color("5CA9F2"),
	"ivory":Color("ddc7c7ff"), 
	"amethyst":Color("6229a9ff"),
	"gold":Color("CDCA4A"),
	"chartreuse":Color("7AA341"),
	"amber":Color("DE6939")
}


func sanitizeDesc(desc):
	var newstring = desc
	for I : String in boardRef.typeToColor.keys():
		var newimgtag = "[img=50 color='COLORCODE']uid://cumki28o8ssgk[/img]".replace("COLORCODE",boardRef.typeToColor[I].to_html())
		newstring = newstring.replace(I.to_upper(),newimgtag)
	return newstring

func makeNew(cardData : CardData, destination : String):
	var opening = FileAccess.open("uid://dfiwiq4q1g61y", FileAccess.READ)
	var baseSVG = opening.get_as_text()
	opening.close()
	
	var newviewport = $SubViewport.duplicate()
	add_child(newviewport)
	newviewport.get_child(0).get_child(0).text = cardData.card_name.to_upper()
	newviewport.get_child(0).get_child(1).text = sanitizeDesc(cardData.text_description)
	newviewport.get_child(0).get_child(2).text = cardData.word
	
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	
	var actualImage : Image = newviewport.get_texture().get_image()
	var bytes : PackedByteArray = actualImage.save_png_to_buffer()
	var data : String = Marshalls.raw_to_base64(bytes)
	var newChunk = baseImage.replace("{{BODY_TEXT}}",data)
	
	var newSVG = baseSVG.replace("<!-- TEXT_LAYER -->",newChunk)
	if cardData.pipCost == 1:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",onepip)
	elif cardData.pipCost == 2:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",twopip)
	elif cardData.pipCost == 3:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",threepip)
	elif cardData.pipCost == 4:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",fourpip)
	elif cardData.pipCost == 5:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",fifthpip)
	elif cardData.pipCost == 6:
		newSVG = newSVG.replace("<!-- PIP_LAYER -->",sixthpip)
	
	
	var newfile = FileAccess.open(destination + "/" + cardData.card_name + ".svg",FileAccess.WRITE)
	newfile.store_string(newSVG)
	newfile.close()


func _on_file_dialog_dir_selected(dir):
	print(dir)
	for I in References.CardHandler.loadedPull.values():
		makeNew(I,dir)
