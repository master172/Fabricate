extends CharacterBody2D

@export var speed = 400
@onready var Health_component :health_component= $health_component
@onready var Charge_component :charge_component= $ChargeComponent
@onready var inventory_component :Inventory_component= $InventoryComponent

func _ready():
	ModuleInfo.inventory = inventory_component
	ModuleInfo.player = self
	
func get_health_component():
	return Health_component

func get_charge_component():
	return Charge_component

func get_inventory_component():
	return inventory_component
	
func get_input():
	look_at(get_global_mouse_position())
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func die():
	queue_free()

func add_module(module:Module):
	var Mod = module.module.instantiate()
	add_child(Mod)
