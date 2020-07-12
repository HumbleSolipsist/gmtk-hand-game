extends Node2D

onready var ouch_sprite = $bug_ouch
onready var idle_sprite = $bug_stand

#onready var hitbox = $hitbox

enum STATE {
	idle,
	hurt
}

var state = STATE.idle

var shakes = 0;

func _ready():
	pass # Replace with function body.

func _process(delta):
	if (state == STATE.hurt):
		ouch_sprite.visible = true;
		idle_sprite.visible = false;
	else:
		ouch_sprite.visible = false;
		idle_sprite.visible = true;

func _physics_process(delta):
	$bug_ouch.offset = Vector2(rand_range(-shakes, shakes), rand_range(-shakes, shakes));
	$bug_stand.offset = Vector2(rand_range(-shakes, shakes), rand_range(-shakes, shakes));
	shakes = max(shakes * 0.75, 0);

func hand_over(hand):
	state = STATE.hurt
	if (hand.item):
		hand.item.hit(self)
		shakes = shakes + 50;
	else:
		$smack_sound.play()
		shakes = shakes + 25;
		hand.close_hand()

func hand_off(hand):
	state = STATE.idle
	if not hand.item:
		hand.open_hand()
