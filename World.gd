extends Node2D

const staff_gap = 5.0
const potion_gap = 3.0

onready var time_to_staff = staff_gap
onready var time_to_potion = potion_gap

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass

func make_new_item(path):
	var new_item = load(path).instance()
	self.add_child(new_item)
	
	var itemx = rand_range(0, 1024)
	var itemy = rand_range(550, 550 - (sin(PI * itemx/1024) * 100))
	new_item.position = Vector2(itemx, itemy)
	
	return new_item

func _physics_process(delta):
	if get_node("/root/world").has_node("opening_screen") or get_node("/root/world/end_screen").visible:
		return
	time_to_potion -= delta
	time_to_staff -= delta
	if (time_to_potion <= 0):
		time_to_potion += potion_gap
		self.make_new_item("res://potion.tscn")
	if (time_to_staff <= 0):
		time_to_staff += potion_gap
		var item = self.make_new_item("res://staff.tscn")