extends GPUParticles2D

func _ready():
	emitting = true


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("enemies"):
		body.get_health_component().damage(50)
