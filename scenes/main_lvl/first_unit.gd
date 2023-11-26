extends Node2D

@onready var anima = $tower_animation

var dragable = false
var is_inside = false
var just_body
var initiationPos : Vector2



func _ready():
	initiationPos = global_position
	get_tree().call_group("dropable_1", change_vis())

func change_vis():
	visible = false

func _process(delta):
	if dragable:
		if Input.is_action_just_pressed("click"):
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside:
				tween.tween_property(self, "position", just_body.position, 0.2).set_ease(Tween.EASE_OUT)
				anima.play("idle")
			else:
				tween.tween_property(self, "global_position", initiationPos, 0.2).set_ease(Tween.EASE_OUT)
			


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group("dropable_1"):
		is_inside = true
		body.modulate = Color(Color.CORNFLOWER_BLUE, 0.5)
	just_body = body
	



func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		dragable = true
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		dragable = false
	scale = Vector2(1,1)


func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable_1"):
		is_inside = true
		body.modulate = Color(Color.AZURE, 0.5)
