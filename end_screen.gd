extends Node2D

var oneshot = false;

func _process(delta):
	if oneshot:
		return
	if get_node("/root/world/left_hand").dead and get_node("/root/world/right_hand").dead:
		visible = true;
		get_node("../bg_music").playing = false
		get_node("./lose_sfx").playing = true
		oneshot = true;