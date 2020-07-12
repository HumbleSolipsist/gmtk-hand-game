extends Area2D

var held_by

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hand_over(hand):
	hand.try_grab(self)

func hand_off(hand):
	pass

func start_despawn_timer():
	yield(get_tree().create_timer(1),"timeout")
	self.queue_free()

func shatter():
	$potion.visible = false
	$potion_break.visible = true
	self.start_despawn_timer()

func hit(enemy):
	self.shatter()
	self.position = enemy.position
	self.held_by.drop_item()
	self.held_by = true
