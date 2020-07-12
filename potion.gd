extends Area2D

var held

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hand_over(hand):
	hand.try_grab(self)

func hand_off (hand):
	pass