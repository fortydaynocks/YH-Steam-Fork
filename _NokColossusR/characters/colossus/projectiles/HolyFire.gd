extends "res://_NokColossusR/characters/colossus/projectiles/CSR-Projectile.gd"

var width = 50
var lifetime = 90
var has_burned_opponent = false

#	--
func detect(obj):
	.detect(obj)
	
	if obj == self.get_owner().opponent:
		self.get_owner().opponent.take_damage(1)
		
		if has_burned_opponent == false:
			self.get_owner().increment_flamestain(0.5)
			has_burned_opponent = true

#	--
func disable():
	.disable()
	
	$"%ParticleEffect".stop_emitting()
	self.stop_sound("Burn")
	self.play_sound("BurnStop")

func tick():
	.tick()
	
	if self.get_owner().was_my_turn == true:
		has_burned_opponent = false
	
	#	--
	if $"%Burn".playing == false:
		self.play_sound("Burn")

	self.set_pos(str(self.get_pos().x), "0")
	
	if self.current_tick >= lifetime:
		disable()

	#	--	WIDTH SETTING
	if current_tick == 1:
		$"%flame-rise".emission_rect_extents.x = width
		$"%flame-rise".amount = width
		$"%flame-static".emission_rect_extents.x = width
		$"%flame-static".amount = width
	
	for hbox in self.get_active_hitboxes():
		hbox.width = width
