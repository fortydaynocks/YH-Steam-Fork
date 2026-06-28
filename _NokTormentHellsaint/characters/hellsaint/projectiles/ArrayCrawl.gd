extends "res://_NokTormentHellsaint/characters/hellsaint/projectiles/THS-Projectile.gd"

var dist = 30
var distmul = 1.0
var interval = 4
var times = 0
var crawl = null

func tick():
	.tick()
	
	if current_tick == interval and times > 0 and crawl and (not self.last_object_hit) and self.get_opponent().combo_count < 1:
		var pos = self.get_pos()
		var fac = self.get_facing_int()
		
		var proj = self.get_owner().spawn_object(crawl, pos.x + (dist * fac), pos.y, false, null, false)
		proj.set_grounded(true)
		proj.set_facing(self.get_facing_int())
		
		proj.dist = dist * distmul
		proj.distmul = distmul
		proj.interval = interval
		proj.times = times - 1
		proj.crawl = crawl
		
