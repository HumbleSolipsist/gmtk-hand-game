extends Node2D

var velocity

func _ready():
	velocity = Vector2(rand_range(-10, 10), rand_range(-20, 0))
	var size = rand_range(0.4, 1)
	scale = Vector2(size, size)

func _physics_process(delta):
	position += velocity
	velocity += Vector2(0, 0.5)