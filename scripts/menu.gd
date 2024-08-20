extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("pause") or Input.is_action_pressed("jump"):
		get_tree().paused = false
	show()
