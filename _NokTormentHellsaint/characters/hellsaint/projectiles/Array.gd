extends "res://_NokTormentHellsaint/characters/hellsaint/projectiles/THS-Projectile.gd"

func hit_by(hitbox):
	self.disable()
	self.get_opponent().projectile_free_cancel()

#	--
func crawl():
	var pos = self.get_pos()
	
	var proj = self.get_owner().spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/ArrayCrawl.tscn"), pos.x + 15, pos.y, false, null, false)
	var proj2 = self.get_owner().spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/ArrayCrawl.tscn"), pos.x - 15, pos.y, false, null, false)
	
	proj.set_grounded(false)
	proj.set_facing(1)
	proj.crawl = preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/ArrayCrawl.tscn")

	proj2.set_grounded(false)
	proj2.set_facing(-1)
	proj2.crawl = preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/ArrayCrawl.tscn")
	
	proj.dist = 30
	proj.times = 3
	
	proj2.dist = 30
	proj2.times = 3
	
	self.disable()
	
func spire():
	self.can_be_hit_by_melee = false
	self.tag = "ArraySpire"
	
	if self.current_state().state_name == "Default":
		self.change_state("Spire")

func star():
	var pos = self.get_pos()
	
	var proj = self.get_owner().spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), pos.x, pos.y, false, null, false)
	proj.set_grounded(false)
	proj.apply_force_relative("0", "-8")
	
	self.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Misc2.tscn"), Vector2())
	self.screen_bump(Vector2(0, 0), 2, 0.1)
	
	self.play_sound("Star")
	self.play_sound("Star2")
	self.disable()
	
	return proj

	
