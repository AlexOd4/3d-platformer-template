class_name PlayerBody3D extends MovableBody3D

func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("ui_down", "ui_up"),
		Input.get_axis("ui_left", "ui_right")
	)
	jumping = Input.is_action_just_pressed("ui_accept")
