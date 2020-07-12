extends Node2D

onready var ouch_sprite = $bug_ouch
onready var idle_sprite = $bug_stand

#onready var hitbox = $hitbox

enum STATE {
	idle,
	hurt
}

var state = STATE.idle

func _ready():
	pass # Replace with function body.

func _process(delta):
	if (state == STATE.hurt):
		ouch_sprite.visible = true;
		idle_sprite.visible = false;
	else:
		ouch_sprite.visible = false;
		idle_sprite.visible = true;

func hand_over(hand):
	state = STATE.hurt
	if (hand.item):
		hand.item.hit(self)
	else:
		$smack_sound.play()
		hand.close_hand()

func hand_off(hand):
	state = STATE.idle
	if not hand.item:
		hand.open_hand()
