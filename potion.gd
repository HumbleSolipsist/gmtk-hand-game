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
	yield(get_tree().create_timer(3),"timeout")
	self.queue_free()

func shatter():
	$potion.visible = false
	$potion_break.visible = true
	$shatter_sound.play()
	self.set_deferred('z_index', 0)
	self.start_despawn_timer()

func hit(enemy):
	self.shatter()
	self.position = enemy.position + Vector2(rand_range(-50, 50), rand_range(-150,150))
	self.held_by.drop_item()
	self.held_by = true
