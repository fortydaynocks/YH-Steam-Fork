extends BaseProjectile

var isittechnicallyarose = true
var can_harvest = false
var ripe = false
var kill = false
var siphon_distance = 75

onready var marker = $"%Marker"

func tick():
	.tick()
	
	if is_instance_valid(marker):
		marker.visible = can_harvest == true and ripe == true and self.disabled == false and kill == false
		marker.playing = marker.visible
		
	if self.creator.opponent.current_state().state_name in ["Knockdown", "HardKnockdown", "Getup"]:
		var distance2opponent = abs(float(self.get_pos().x) - float(self.creator.opponent.get_pos().x))

		if distance2opponent < siphon_distance:
			if current_tick % 3 == 0:
				self.creator.gain_super_meter_raw(2)
	
	if kill == true:
		disable()
		return

func hit_by(hitbox):
	var ohost = self.objs_map[hitbox.host]
	if ohost is Fighter:
		self.spawn_particle_effect(self.creator.vfx_table.Harvest, Vector2(float(self.get_pos().x), float(self.get_pos().y - 22)))
		self.play_sound("CutDown")
		self.creator.opponent.projectile_free_cancel()
					
		self.creator.stress += 0.12
	
	.hit_by(hitbox)
	kill = true

func disable():
	self.creator.bloodflowers.erase(self.obj_name)
	
	.disable()
	
#	--	
func graduate():
	kill = true
	
	if len(self.creator.monoliths) <= 0 and self.creator.monoliths_created_in_combo[0] < self.creator.monoliths_created_in_combo[1]:
		self.creator.monoliths_created_in_combo[0] += 1
		
		var obj = self.creator.spawn_object(self.creator.objs_table.Monolith, float(self.get_pos().x), float(self.get_pos().y), false, null, false)
		self.creator.monoliths.append(obj.obj_name)
		
		#	--
		for eye in self.creator.eyes:
			var eye_obj = self.objs_map[eye]
				
			if is_instance_valid(eye_obj) and is_instance_valid(eye_obj.target):
				if eye_obj.target.obj_name == self.obj_name:
					eye_obj.change_state("Activate")
