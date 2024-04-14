extends Node2D

var player_in:bool = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in = false

func _physics_process(delta):
	if !player_in:
		return
	
	if Input.is_action_just_pressed("interact"):
		Forge.get_child(0).activate()
