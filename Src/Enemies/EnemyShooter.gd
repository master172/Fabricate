extends "res://Src/Enemies/EnemyBase.gd"

@onready var gun :CharacterBody2D= $Gun

var target_in_range:bool = false

func _on_shoot_timer_timeout():
	if target_in_range == true:
		shoot()

func shoot():
	if movement_target != null:
		gun.shoot(movement_target)


func _on_shoot_radius_body_entered(body):
	if body.is_in_group("player"):
		target_in_range = true

func _on_shoot_radius_body_exited(body):
	if body.is_in_group("player"):
		target_in_range = false
