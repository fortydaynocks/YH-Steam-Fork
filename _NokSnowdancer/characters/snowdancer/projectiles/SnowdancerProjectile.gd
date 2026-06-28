extends BaseProjectile

export (int) var _c_snowdancer

export (String) var identity
export (int) var resist_blocks = 1
export (int) var resist_parries = 1
export (int) var resist_clashes = 1
export (bool) var ignore_cold_vortex = false
export (float) var cold_vortex_push_force = 0.5

export (int) var glac_block = 25

#	--
var is_snowdancer_proj = true

func _ready():
	._ready()
	
	state_variables.append_array(
		[
		"identity",
		"resist_blocks",
		"resist_parries",
		"resist_clashes",
		"ignore_cold_vortex",
		"cold_vortex_push_force",
		"is_snowdancer_proj",
		"glac_block",
		]
	)
	
func on_got_blocked():
	.on_got_blocked()
	
	if resist_blocks != -1:
		resist_blocks -= 1
		
		if resist_blocks <= 0:
			self.disable()
			
	self.creator.increment_glac(glac_block)
		
func on_got_parried():
	.on_got_parried()
	
	if resist_parries != -1:
		resist_parries -= 1
		
		if resist_parries <= 0:
			self.disable()

func hit_by(hitbox:Hitbox):
	.hit_by(hitbox)
	
	if resist_clashes != -1:
		resist_clashes -= 1
		
		if resist_clashes <= 0:
			self.disable()
			
func tick():
	.tick()
