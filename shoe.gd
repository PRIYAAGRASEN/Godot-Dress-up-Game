extends Node2D


var draggable = false
var is_inside_dropableshoe = false
var body_ref
var offset: Vector2
var initialPos : Vector2

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging=true
		
		
		
		if Input.is_action_pressed("click"):
			global_position=get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Global.is_dragging =false
			var tween = get_tree().create_tween()
			if is_inside_dropableshoe:
				tween.tween_property(self,"position",body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position", initialPos , 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(0.7,0.678)
func _on_area_2d_mouse_exited():
	if not Global.is_dragging :
		draggable=false
		scale = Vector2(0.66,0.644)

		

func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group('dropableshoe'):
		is_inside_dropableshoe = true
		body.modulate = Color(Color.AZURE,0.5)
		body_ref = body
		

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropableshoe'):
		is_inside_dropableshoe = false
		body.modulate = Color(Color.ALICE_BLUE,0.7)


