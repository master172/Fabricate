extends Control

@onready var options :VBoxContainer = $TabContainer/Forge/MainContainer/Forge/Panel/ScrollContainer/Options
@onready var image :TextureRect= $TabContainer/Forge/MainContainer/Forge/Details/Details/Image
@onready var description :RichTextLabel= $TabContainer/Forge/MainContainer/Forge/Details/Details/Panel/Description
@onready var scraps :Button= $TabContainer/Forge/MainContainer/Buttons/VBoxContainer/Scraps
@onready var blueprint :Button= $TabContainer/Forge/MainContainer/Buttons/VBoxContainer/Blueprint
@onready var craft :Button= $TabContainer/Forge/MainContainer/Buttons/Craft

# Called when the node enters the scene tree for the first time.

var selected_module:Module

func _ready():
	visible = false
	for i in options.get_children():
		i.item_pressed.connect(update_item)

func activate():
	visible = true
	ModuleInfo.player.set_physics_process(false)

func unactivate():
	visible = false
	await get_tree().create_timer(0.1).timeout
	ModuleInfo.player.set_physics_process(true)

func update_item(module:Module):
	selected_module = module
	check_craftable()
	print(module.Blueprint_requirement.Blue_print_name)
	image.texture = module.sprite
	description.text = module.Description
	
	scraps.text = str(selected_module.Scrap_requirement)
	blueprint.text = selected_module.Blueprint_requirement.Blue_print_name + " blueprint"


func _on_button_pressed():
	unactivate()

func check_craftable():
	if ModuleInfo.inventory.Metal_scraps <  selected_module.Scrap_requirement:
		craft.disabled = true
	elif !ModuleInfo.inventory.Blueprints.has(selected_module.Blueprint_requirement):
		craft.disabled = true
	else:
		craft.disabled = false
		
func _on_craft_pressed():
	if ModuleInfo.inventory.Metal_scraps <  selected_module.Scrap_requirement:
		return
	if !ModuleInfo.inventory.Blueprints.has(selected_module.Blueprint_requirement):
		return
	
	ModuleInfo.modules.append(selected_module.module)
	ModuleInfo.inventory.Metal_scraps -= selected_module.Scrap_requirement
	ModuleInfo.inventory.Blueprints.erase(selected_module.Blueprint_requirement)
	
	check_craftable()
