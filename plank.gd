extends Area2D

var held_by = null
var hit_count = 0

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
	yield(get_tree().create_timer(2),"timeout")
	self.queue_free()

func shatter():
	self.held_by.drop_item()
	self.held_by = true
	$staff.visible = false
	$staff_broken.visible = true
	$shatter_sound.play()
	self.z_index = 0
	self.start_despawn_timer()

func hit(enemy):
	$door_hit_sound.play()
	self.hit_count += 1
	if rand_range(0, self.hit_count) > 3:
		self.shatter()