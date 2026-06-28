extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

export var adjustable_mgb = false
var saved_vel = {
	x = "0.0",
	y = "0.0"
}

#onready var h = $Hitbox

func _enter():
	._enter()
	
	for h in all_hitbox_nodes:
		if name in ["machinegunblow", "machinegunblowair"]:
			h.damage = 100
		else:
			h.damage = 130

func _frame_1():
	if name == "exmachinegunblow":
		current_tick += 1

func _frame_3():
	if self.ex == true and host.initiative:
		host.start_projectile_invulnerability()
	
func _frame_10():
	if self.ex == true:
		host.end_projectile_invulnerability()

func _tick():
	._tick()
	
	if hitted == true and host.opponent.current_state().get("IS_NEW_PARRY"):
		host.set_vel(saved_vel.x, saved_vel.y)
		host.opponent.set_vel(saved_vel.x, saved_vel.y)
	
	if adjustable_mgb == true:
		var dist = 0
		if data:
			if not "ex" in name:
				dist = data.x/10
			else:
				dist = data.x/8
		else:
			dist = 0
		
		if current_tick == 3:
			host.apply_force_relative("4", "0")
			
		if current_tick == 8:
			host.update_facing()
		
		if current_tick in [3, 4, 5, 6, 7, 8]:
			host.move_directly_relative(str(dist), "0")
	
	if current_tick in [1, 4, 7]:
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(host.get_facing_int(), 0))

func on_got_blocked():
	.on_got_blocked()
	saved_vel = host.get_vel()
	if not name in ["machinegunblow", "machinegunblowair"]:
		hitted = true
	for h in all_hitbox_nodes:
		h.damage = 0

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj is Fighter:
		host.start_invulnerability()
		for h in all_hitbox_nodes:
			h.damage = 0
