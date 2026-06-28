extends "res://_NokDeoR/characters/deo/projectiles/DeoR-Projectile.gd"

var stage = [1, 3]
var turns_alive = 0
var level_increment = 3
var time = [0, 10, 10]
var hbox_size = {
	"value": Vector2(50, 50),
	"initial": 50,
	"increment": 15,
}
var stacked = false

func stack():
	level_up(4)
	stacked = true
	
	self.play_sound("Boost")
	self.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Star2.tscn"))
	self.screen_bump(Vector2(), 2, 0.1)

func level_up(level):
	if level <= stage[0]: return
	
	stage[0] = level
	hbox_size.value = Vector2(hbox_size.initial + (hbox_size.increment * (stage[0] - 1)), hbox_size.initial + (hbox_size.increment * (stage[0] - 1)))
	self.sprite.scale = Vector2(1.5 + (0.25 * (stage[0] - 1)), 1.5 + (0.25 * (stage[0] - 1)))
	print(self.sprite.scale)
	
	self.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Star1.tscn"))
	self.play_sound("Grow")
	self.rumble(1, 10)

#	--
func hit_by(hitbox):
	self.disable()

func tick():
	.tick()
	
	time[0] = time[1] + (time[2] * (stage[0] - 1))
				
	#	--	COLLISION LEVELLING
	for obj in self.objs_map.values():
		if is_instance_valid(obj) and (not obj.disabled) and obj != self and obj.get_owner() == self.get_owner() and obj.get("tag") == "Timezone":
			if (self.current_state().state_name == "Default" and obj.current_state().state_name == "Default") and (stacked == false and obj.stacked == false):
				if self.collision_box.overlaps(obj.collision_box):
					stack()
					obj.disable_particle = null
					obj.disable()
	
	#	--	LEVELLING
	if (self.get_owner().was_my_turn or self.get_opponent().was_my_turn) and current_state().state_name in ["Default"]:
		turns_alive += 1
		
		if turns_alive == level_increment:
			level_up(2)
			
		elif turns_alive == level_increment * 2:
			level_up(3)

func _process(delta):
	._process(delta)
	
	$"%Info".bbcode_text = "[center][color=#ddb563]"
	$"%Info".bbcode_text += "Stage: " + str(stage[0])
	if stacked: $"%Info".bbcode_text += "\n[color=#ff0000]Stacked"
	
	$"%Range".visible = self.is_ghost and (not self.disabled)
	$"%Range".scale_amount = (float(hbox_size.value.x) / 32.0) + 0.1
	#$"%Range".modulate.a = 0.5
	#$"%RangeRect".rect_position = Vector2(-hbox_size.value.x, -hbox_size.value.y)
	#$"%RangeRect".rect_size = Vector2(hbox_size.value.x * 2, hbox_size.value.y * 2)
