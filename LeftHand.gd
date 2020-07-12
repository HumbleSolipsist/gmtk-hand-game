extends Area2D

export (float) var active_speed
export (float) var passive_speed

var home
onready var open_sprite = $arm_open
onready var closed_sprite = $arm_closed_bottom
onready var fingers_sprite = $arm_closed_top
onready var open_hitbox = $open_hand_hitbox
onready var closed_hitbox = $closed_hand_hitbox

var mouse_hover = false
var follow_mouse = false

var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.home = self.position
	open_hand()

func travel_to(destination, speed):
	if destination.distance_to(self.position) > speed:
		var velocity = (destination - self.position).normalized() * speed
		self.position = self.position + velocity
	else:
		self.position = destination

func go_to_mouse():
	self.travel_to(get_viewport().get_mouse_position(), active_speed)

func go_home():
	self.travel_to(self.home, passive_speed)

func open_hand():
	open_sprite.visible = true
	closed_sprite.visible = false
	fingers_sprite.visible = false
	open_hitbox.disabled = false
	closed_hitbox.disabled = true

func close_hand():
	open_sprite.visible = false
	closed_sprite.visible = true
	fingers_sprite.visible = true
	open_hitbox.disabled = true
	closed_hitbox.disabled = false

func drop_item():
	self.item.held = false
	self.item = null
	open_hand()

func give_item():
	var temp = self.item
	self.drop_item()
	return temp

func grab(item):
	self.item = item
	item.held = true
	close_hand()

func try_grab(item):
	if not self.item and not item.held:
		self.grab(item)
		return true
	return false

func _physics_process(delta):
	if follow_mouse:
		self.go_to_mouse()
	else:
		self.go_home()
	
	if item:
		item.position = self.position
	
func _input(event):
	if mouse_hover and event is InputEventMouseButton:
		follow_mouse = not follow_mouse

func mouse_over(mouse_pointer):
	mouse_hover = true

func mouse_off(mouse_pointer):
	mouse_hover = false

func _on_hand_area_entered(area):
	if (area.has_method("hand_over")):
		area.hand_over(self)

func _on_hand_area_exited(area):
	if (area.has_method("hand_off")):
		area.hand_off(self)