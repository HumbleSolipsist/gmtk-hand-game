extends Node2D

const staff_gap = 3.0
const potion_gap = 1.0

onready var time_to_staff = staff_gap
onready var time_to_potion = potion_gap

var potion_count = 0
var staff_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass

func blood_splat(location):
	for i in range(1, 15):
		var blood_drop = load("res://blood_drop.tscn").instance()
		self.add_child(blood_drop)
		blood_drop.position = location

func make_new_item(path):
	var new_item = load(path).instance()
	self.add_child(new_item)
	
	var itemx = rand_range(0, 1024)
	var itemy = rand_range(550, 550 - (sin(PI * itemx/1024) * 100))
	new_item.position = Vector2(itemx, itemy)
	
	return new_item

func _physics_process(delta):
	if self.has_node("opening_screen") or get_node("/root/world/end_screen").visible:
		return
	time_to_potion -= delta / (potion_count + 1)
	time_to_staff -= delta / (staff_count + 1)
	if (time_to_potion <= 0):
		time_to_potion += potion_gap
		self.make_new_item("res://potion.tscn")
	if (time_to_staff <= 0):
		time_to_staff += potion_gap
		var item = self.make_new_item("res://staff.tscn")