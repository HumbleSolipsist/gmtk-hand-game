extends RigidBody2D

onready var misses = [$lame, $meh]
onready var hits = [$lotta_damage, $oof, $ouch, $wow]

func init(type):
	if (type == 'miss'):
		misses[rand_range(0, misses.size())].visible = true;
	if (type == 'hit'):
		hits[rand_range(0, hits.size())].visible = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	var signn = 1
	if randi() % 2 == 0:
		signn = -1
	apply_central_impulse(Vector2(rand_range(250, 500) * signn, rand_range(-1000, -1250)));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if self.position.y > 1000:
	#	queue_free()
