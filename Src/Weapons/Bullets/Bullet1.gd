extends CharacterBody2D

@export var damage :int = 20

func _ready():
	top_level = true
	
func _physics_process(delta):
	move_and_slide()


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body == self:
		return
	var victim = body
	if body.is_in_group("enemies"):
		victim.get_health_component().damage(damage)
	elif body.is_in_group("player"):
		victim.get_health_component().damage(damage*0.1)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
