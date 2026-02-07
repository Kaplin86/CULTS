extends Node3D


func _on_normal_pressed():
	Transition.transition("uid://xg852gnosvsa")

func _on_start_pressed():
	Transition.transition("uid://xg852gnosvsa")
	for I in objects:
		References.set(I.name,I.find_child("ValueSource").value)

func _on_custom_pressed():
	$Node2D/Panel.visible = true
	$Node2D/Control/HBoxContainer.visible = false
	for I in objects:
		I.find_child("ValueSource").value = I.get_meta("default")


func customRoundSettingPressed(value,type,object):
	References.set(type,object.find_child("ValueSource").value)
	object.find_child("CurrentVal").text = str(object.find_child("ValueSource").value)

var objects = []

func _ready():
	for I in $Node2D/Panel.get_children():
		
		if I.find_child("ValueSource"):
			objects.append(I)
			var valsource : HSlider = I.find_child("ValueSource")
			valsource.value = References.get(I.name)
			I.set_meta("default",References.get(I.name)) 
			if References.get(I.name) is int:
				valsource.step = int(1)
			valsource.drag_ended.connect(customRoundSettingPressed.bind(I.name,I))

func _process(delta):
	for I in objects:
		var valsource : HSlider = I.find_child("ValueSource")
		if I.get_meta("default") is int:
			I.find_child("CurrentVal").text = str(int(valsource.value))
		else:
			I.find_child("CurrentVal").text = str(valsource.value)
		if I.name == "CPUCount":
			valsource.max_value = References.PlayerCount


func _on_cancel_pressed():
	$Node2D/Panel.visible = false
	$Node2D/Panel.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	$Node2D/Control/HBoxContainer.visible = true
