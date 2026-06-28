extends "res://_NokPsychoR/characters/psycho/projectiles/PsychoProjectile.gd"

func on_got_blocked_by(who):
	.on_got_blocked_by(who)
	
	if who == self.creator.opponent:
		for hbox in self.get_active_hitboxes():
			self.creator.scars += 1

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == self.creator.opponent:
		if self.creator.insanity == true:
			self.creator.insanity_knife(hitbox)
