extends Area2D

export (float) var active_speed
export (float) var passive_speed
export (Vector2) var home

var mouse_hover = false
var follow_mouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

func _physics_process(delta):
	if follow_mouse:
		self.go_to_mouse()
	else:
		self.go_home()
	
func _input(event):
	if mouse_hover and event is InputEventMouseButton:
		follow_mouse = not follow_mouse

func _on_pointer_area_entered(area):
	mouse_hover = true

func _on_pointer_area_exited(area):
	mouse_hover = false