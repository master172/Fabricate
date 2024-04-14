extends Node2D

var target:Node2D

var move_speed:int = 500

@export var blueprint:Blueprint = Blueprint.new()

func _ready():
	top_level = true
	
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position,delta*move_speed)


func _on_range_area_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_add_area_body_entered(body):
	if body.is_in_group("player"):
		body.get_inventory_component().Blueprints.append(blueprint)
		queue_free()
