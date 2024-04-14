extends Control

@onready var options :VBoxContainer = $TabContainer/Forge/MainContainer/Forge/Panel/ScrollContainer/Options
@onready var image :TextureRect= $TabContainer/Forge/MainContainer/Forge/Details/Details/Image
@onready var description :RichTextLabel= $TabContainer/Forge/MainContainer/Forge/Details/Details/Panel/Description
@onready var scraps :Button= $TabContainer/Forge/MainContainer/Buttons/VBoxContainer/Scraps
@onready var blueprint :Button= $TabContainer/Forge/MainContainer/Buttons/VBoxContainer/Blueprint
@onready var craft :Button= $TabContainer/Forge/MainContainer/Buttons/Craft
@onready var equip_options :VBoxContainer= $TabContainer/Equip/MainContainer/Forge/Panel/ScrollContainer/Options

# Called when the node enters the scene tree for the first time.
const equip_item = preload("res://Src/Ui/EquipItem.tscn")

var selected_module:Module
var to_equp_item:Module

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
	
	ModuleInfo.modules.append(selected_module)
	ModuleInfo.inventory.Metal_scraps -= selected_module.Scrap_requirement
	ModuleInfo.inventory.Blueprints.erase(selected_module.Blueprint_requirement)
	
	check_craftable()
	
	add_equip_items()

func add_equip_items():
	for i in equip_options.get_children():
		i.queue_free()
	
	for i in ModuleInfo.modules:
		var item_to_add = equip_item.instantiate()
		item_to_add.Item = i
		equip_options.add_child(item_to_add)
		item_to_add.item_pressed.connect(equip_item_pressed)

func equip_item_pressed(item:Module):
	to_equp_item = item
	print(item.Blueprint_requirement.Blue_print_name)


func _on_equip_pressed():
	if ModuleInfo.player == null:
		return
	
	ModuleInfo.player.add_module(to_equp_item)
	ModuleInfo.modules.erase(to_equp_item)
	to_equp_item = null
	add_equip_items()
