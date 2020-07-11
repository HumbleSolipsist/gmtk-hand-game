extends Area2D

func go_to_mouse():
	self.position = get_viewport().get_mouse_position()

func _ready():
	self.go_to_mouse()

func _process(delta):
	self.go_to_mouse()

func _on_pointer_area_entered(area):
	if (area.has_method("mouse_over")):
		area.mouse_over(self)

func _on_pointer_area_exited(area):
	if (area.has_method("mouse_off")):
		area.mouse_off(self)
