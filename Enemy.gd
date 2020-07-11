extends Node2D

onready var ouch_sprite = $bug_ouch
onready var idle_sprite = $bug_stand

onready var hitbox = $hitbox

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

func hand_over(area):
	if (area.item):
		# do item.thing
		pass
	else:
		state = STATE.hurt

func hand_off(area):
	pass
