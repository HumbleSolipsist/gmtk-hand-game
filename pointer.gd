extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func go_to_mouse():
	self.position = get_viewport().get_mouse_position()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.go_to_mouse()

func _process(delta):
	self.go_to_mouse()

func _on_pointer_area_entered(area):
	if (area.has_method("mouse_over")):
		area.mouse_over()


func _on_pointer_area_exited(area):
	if (area.has_method("mouse_off")):
		area.mouse_off()
