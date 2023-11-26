extends StaticBody2D

func _ready():
	modulate = Color(Color.AZURE, 0.5)

func _process(delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
		
