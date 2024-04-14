extends Node2D
class_name Inventory_component

@export var Metal_scraps:int = 0 :
	get:
		return Metal_scraps
	set(value):
		Metal_scraps = value
@export var Blueprints :Array[Blueprint] = [] :
	get:
		return Blueprints
	set(value):
		Blueprints = value
