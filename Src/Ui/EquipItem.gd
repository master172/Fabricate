extends Button
class_name Equip_item

@export var Item:Module = Module.new()

signal item_pressed(Item)

func _ready():
	if Item != null:
		self.text = Item.Blueprint_requirement.Blue_print_name
		self.icon = Item.sprite
		self.pressed.connect(item)

func item():
	emit_signal("item_pressed",Item)
