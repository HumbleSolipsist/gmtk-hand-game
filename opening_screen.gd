extends Node2D

var current = 0;

onready var slides = [$slide1, $slide2, $slide3];

func _ready():
	updateSlide()

func updateSlide():
	for i in range(0, slides.size()):
		slides[i].visible = false;
	if (current < slides.size()):
		slides[current].visible = true;
	else:
		get_node("../bg_music").playing = true
		queue_free()

func _input(ev):
	if (ev is InputEventKey and ev.pressed) or (ev is InputEventMouseButton and ev.pressed):
		current = current + 1
		updateSlide()
