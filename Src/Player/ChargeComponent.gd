extends Node2D
class_name charge_component

@export var max_charge :int = 100
@export var charge :int = 100

func discharge(val:int):
	charge -= val
	charge = clamp(charge,0,max_charge)

func recharge(val:int):
	charge += val 
	charge = clamp(charge,0,max_charge)

func get_charge():
	return charge

func get_max_charge():
	return max_charge
