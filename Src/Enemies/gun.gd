extends CharacterBody2D

@export var bullet_speed :int = 1500

const bullet = preload("res://Src/Weapons/Bullets/Bullet1.tscn")
@onready var marker_2d :Marker2D= $Marker2D

@export var Charge_component:charge_component

func shoot(target):
	if charge_component == null:
		return
		
	Charge_component.discharge(1)
	var can_shoot : bool = Charge_component.get_charge()
	
	if can_shoot == false:
		return
	
	var Bullet = bullet.instantiate()
	Bullet.global_position = marker_2d.global_position
	Bullet.velocity = (target.global_position - Bullet.position).normalized() * bullet_speed
	Bullet.look_at(target.global_position - Bullet.position)
	get_tree().current_scene.add_child(Bullet)
