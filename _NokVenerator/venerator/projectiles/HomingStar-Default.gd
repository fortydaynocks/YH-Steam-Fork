extends DirProjectileDefault

var expiry = 10

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.get_opponent():
		self.lifetime = current_tick + expiry
		self.homing_accel = "0"
		self.homing_turn_speed = "0"

func _got_parried():
	#	--	no supercall here.
	self.lifetime = current_tick + expiry
	self.homing_accel = "0"
	self.homing_turn_speed = "0"
	
	host.play_sound("Blocked")

func when_hit():
	self.lifetime = current_tick + expiry
	self.homing_accel = "0"
	self.homing_turn_speed = "0"

func _tick():
	._tick()
	
	host.sprite.rotation_degrees = 0
