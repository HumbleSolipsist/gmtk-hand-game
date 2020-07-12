extends KinematicBody2D

var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.position += velocity
	self.velocity += Vector2(0, 1)
