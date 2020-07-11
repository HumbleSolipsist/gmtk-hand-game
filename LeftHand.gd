extends Area2D

var mouse_hover = false
var follow_mouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if follow_mouse:
		self.position = get_viewport().get_mouse_position()
	
func _input(event):
	if mouse_hover and event is InputEventMouseButton:
		follow_mouse = not follow_mouse

func _on_pointer_area_entered(area):
	mouse_hover = true

func _on_pointer_area_exited(area):
	mouse_hover = false
