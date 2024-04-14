extends Node2D
class_name health_component

@export var max_health :int = 100
@export var health :int = 100

signal health_depleted

func damage(val:int):
	health -= val
	health = clamp(health,0,max_health)
	
	if health <= 0:
		health_depleted.emit()

func heal(val:int):
	health += val 
	health = clamp(health,0,max_health)

func get_health():
	return health

func get_max_health():
	return max_health
