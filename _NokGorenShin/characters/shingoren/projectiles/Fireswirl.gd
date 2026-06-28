extends "res://_NokGorenShin/characters/shingoren/projectiles/SG-Projectile.gd"

var is_fireswirl = false

func hit_by(hitbox):
	self.disable()
	self.get_opponent().projectile_free_cancel()

func tick():
	.tick()
	
	#	--	DUPE DESTROYING
	for obj in self.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == self.get_owner() and obj.get("tag") == self.tag:
			if obj != self and obj.current_tick < self.current_tick:
				self.disable()
