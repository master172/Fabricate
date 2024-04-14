extends CharacterBody2D

@export var movement_speed :float = 100.0

@export var movement_target:Node2D

@export var navigation_agent:NavigationAgent2D

@onready var Health_component :health_component= $health_component

const explosion = preload("res://Src/components/ExplosionParticles.tscn")
const Point_box = preload("res://Src/components/PointBox.tscn")

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	
	if movement_target != null:
		set_movement_target(movement_target.position)

func set_movement_target(target_pos:Vector2):
	navigation_agent.target_position = target_pos

func _physics_process(delta):
	if !is_instance_valid(navigation_agent):
		return
	if navigation_agent.is_navigation_finished():
		return
	
	if movement_target != null:
		look_at(movement_target.global_position)
	
	var current_agent_position:Vector2 = global_position
	var next_path_position:Vector2 = navigation_agent.get_next_path_position()
	
	var new_velocity:Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	
	new_velocity = new_velocity*movement_speed
	velocity = new_velocity
	move_and_slide()


func _on_recalc_timer_timeout():
	if movement_target != null:
		set_movement_target(movement_target.position)

func die():
	add_points()
	queue_free()

func add_points():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var to_add_points = rng.randi_range(3,5)
	print(to_add_points)
	for i in range(to_add_points):
		var point = Point_box.instantiate()
		point.point_class = rng.randi_range(0,1)
		print(point.point_class)
		point.global_position = global_position + Vector2(rng.randi_range(-15,15),rng.randi_range(-15,15))
		print(point.global_position)
		get_tree().current_scene.call_deferred("add_child",point)
		

func get_health_component():
	return Health_component


func _on_explode_radius_body_entered(body):
	if body != self:
		explode()

func explode():
	var EXPLOSION = explosion.instantiate()
	EXPLOSION.global_position = self.global_position
	get_tree().current_scene.call_deferred("add_child",EXPLOSION)
	EXPLOSION.top_level = true
	
	if Health_component.get_health() > 0:
		die()


func _on_area_2d_body_entered(body):
	if movement_target == null:
		if body.is_in_group("player"):
			movement_target = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		movement_target = null
