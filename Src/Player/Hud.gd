extends Control

@export var Charge_comp :charge_component
@export var health_comp :health_component
@export var inventory_comp :Inventory_component

@onready var charge_bar :ProgressBar = $Charge
@onready var health_bar :ProgressBar= $Health
@onready var Blueprint_label = $VBoxContainer/BluePrints/Label
@onready var Scrap_label = $VBoxContainer/Metal/Label

func _physics_process(delta):
	if Charge_comp != null:
		charge_bar.max_value = Charge_comp.max_charge
		charge_bar.value = Charge_comp.charge
	
	if health_comp != null:
		health_bar.max_value = health_comp.max_health
		health_bar.value = health_comp.health
	
	if inventory_comp != null:
		Scrap_label.text = str(inventory_comp.Metal_scraps)
		Blueprint_label.text = str(inventory_comp.Blueprints.size())
		
