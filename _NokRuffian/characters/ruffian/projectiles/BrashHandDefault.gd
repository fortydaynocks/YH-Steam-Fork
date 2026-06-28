extends DefaultFireball


onready var hitbox = $"%HitboxBrashHand"
onready var hitbox2 = $"%HitboxBrashHand2"

func _frame_0():
	._frame_0()
	
	
	
	if host.get_fighter().current_state().name == "brasherhand":
		hitbox.hitstun_ticks = 8
		hitbox2.hitstun_ticks = 8
	else:
		hitbox.hitstun_ticks = 11
		hitbox2.hitstun_ticks = 11
	hitbox.di_modifier = fixed.add(hitbox.di_modifier, str(host.get_fighter().visible_combo_count/10))
	hitbox2.di_modifier = fixed.add(hitbox.di_modifier, str(host.get_fighter().visible_combo_count/10))
