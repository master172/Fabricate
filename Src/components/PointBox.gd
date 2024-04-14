extends Sprite2D

var target:Node2D

var move_speed:int = 500

@export var Value:int = 20
@export_enum("Health", "Mana") var point_class: int

func _ready():
	top_level = true
	if point_class == 0:
		self_modulate = Color.GREEN
	elif point_class == 1:
		self_modulate = Color.CYAN
	
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position,delta*move_speed)


func _on_range_area_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_add_area_body_entered(body):
	if body.is_in_group("player"):
		if point_class == 0:
			body.get_health_component().heal(Value)
			queue_free()
		elif point_class == 1:
			body.get_charge_component().recharge(Value)
			queue_free()
		
