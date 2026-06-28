extends "res://_NokBetrayer/characters/betrayer/projectiles/BT-Projectile.gd"

var next_attack = null

#	--
func _create_speed_after_image(color:Color = Color.white, lifetime = 0.2):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1

#	--
func disable():
	.disable()
	
	self.play_sound("Disable")
	#self._create_speed_after_image(Color("#006aff"), 0.2)
	self.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(0, -18))
	
	self.get_owner().knight.Knight = null

func hit_by(hitbox):
	.hit_by(hitbox)
	
	if hitbox and hitbox.get("host") and hitbox.host == self.get_owner().opponent.obj_name:
		var pos = self.get_pos()
		var opos = self.get_owner().opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		self.apply_force(str(vec.x * -25), str(vec.y * -25))

func tick():
	.tick()
	
	if self.get_owner().hitlag_ticks > 0 and self.current_state().current_tick > 0:
		self.hitlag_ticks = self.get_owner().hitlag_ticks
	
	var pos = self.get_pos()
	var vel = Vector2(self.get_vel().x, self.get_vel().y)
	
	if current_tick == 1:
		self.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc1.tscn"), Vector2(0, -18))
		
		if self.get_owner().get_node("%Stuff").skin == "Munanyou":
			self.play_sound("SpawnMu")
			self.play_sound("SpawnMu2")
			
		else:
			self.play_sound("Spawn1")
		
		self.screen_bump(Vector2(0, 0), 4, 0.1)
		
		self.global_hitlag(6)
		
	
	var offset_vel = Vector2((-vel.x * self.get_facing_int()) * 3, (-vel.y) * 3)
	$"%Wings".position = lerp($"%Wings".position, offset_vel, 0.2)
	
	if self.get_owner().get_node("%Stuff").skin == "Munanyou":
		if current_tick == 1:
			$"%Wings".frames = self.sprite.frames
			$"%Wings".modulate = Color("5300ff")
			$"%Wings".self_modulate.a = 0.5
			$"%Wings".z_index = -1
			
			$"%wings-particle".texture = $"%Wings".frames.get_frame($"%Wings".animation, $"%Wings".frame)
			$"%wings-particle".modulate.a = 0.5
			
			self.get_owner().get_node("%Stuff").recursive_style_modulation(self)
			
			if not (not "Activated" in $"%Mu-Kanji".editor_description):
				match self.current_state().state_name:
					"Truth":
						$"%kanji1".anim_offset = 0
						$"%kanji2".anim_offset = 0
					"Might":
						$"%kanji1".anim_offset = 0.2
						$"%kanji2".anim_offset = 0.2
					"Order":
						$"%kanji1".anim_offset = 0.35
						$"%kanji2".anim_offset = 0.35
					"Shadow":
						$"%kanji1".anim_offset = 0.5
						$"%kanji2".anim_offset = 0.5
					"Acumen":
						$"%kanji1".anim_offset = 0.7
						$"%kanji2".anim_offset = 0.7
					"Justice":
						$"%kanji1".anim_offset = 1
						$"%kanji2".anim_offset = 1
				
				$"%Mu-Kanji".editor_description = "Activated"
				$"%Mu-Kanji".start()
			
			
