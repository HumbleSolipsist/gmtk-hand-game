extends Area2D

export (float) var active_speed
export (float) var passive_speed
export (String) var tear_spot_name

onready var home = self.position
onready var open_sprite = $arm_open
onready var closed_sprite = $arm_closed_bottom
onready var fingers_sprite = $arm_closed_top
onready var open_hitbox = $open_hand_hitbox
onready var closed_hitbox = $closed_hand_hitbox
onready var thumb_hitbox = $thumb_hitbox

var mouse_hover = false
var follow_mouse = false

var item = null

var velocity = Vector2(0, 0)
var spin = 0
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	open_hand()

func travel_to(destination, speed):
	if destination.distance_to(self.position) > speed:
		var velocity = (destination - self.position).normalized() * speed
		self.position = self.position + velocity
		self.velocity = velocity
	else:
		self.velocity = destination - self.position
		self.position = destination

func go_to_mouse():
	self.travel_to(get_viewport().get_mouse_position(), active_speed)

func go_home():
	self.travel_to(self.home, passive_speed)

func open_hand():
	open_sprite.visible = true
	closed_sprite.visible = false
	fingers_sprite.visible = false

func close_hand():
	open_sprite.visible = false
	closed_sprite.visible = true
	fingers_sprite.visible = true

func drop_item():
	self.item.held_by = null
	self.item = null
	open_hand()

func grab(item):
	self.item = item
	item.held_by = self
	close_hand()

func try_grab(item):
	if not self.item and not item.held_by:
		self.grab(item)
		return true
	return false

func fall():
	self.velocity += Vector2(0, 0.5)
	self.position += velocity
	self.rotation += self.spin

func _physics_process(delta):
	if dead:
		fall()
	else:
		if follow_mouse:
			self.go_to_mouse()
		else:
			self.go_home()
	if item:
		item.position = self.position
	
func _input(event):
	if mouse_hover and event is InputEventMouseButton:
		follow_mouse = event.pressed

func mouse_over(mouse_pointer):
	mouse_hover = true

func mouse_off(mouse_pointer):
	mouse_hover = false

func _on_hand_area_entered(area):
	if (area.has_method("hand_over")):
		area.hand_over(self)

func _on_hand_area_exited(area):
	if (area.has_method("hand_off")):
		area.hand_off(self)

func fall_off():
	self.spin = rand_range(-PI/80, PI/80)
	self.velocity *= 0.4
	self.follow_mouse = false
	self.mouse_hover = false
	self.dead = true
	self.closed_hitbox.set_deferred("disabled", true)
	self.open_hitbox.set_deferred("disabled", true)
	self.thumb_hitbox.set_deferred("disabled", true)
	$bone/bone_hitbox.set_deferred("disabled", true)

func _on_bone_area_entered(area):
	if area.name == self.tear_spot_name:
		self.fall_off()
		$tear_sound.play()
