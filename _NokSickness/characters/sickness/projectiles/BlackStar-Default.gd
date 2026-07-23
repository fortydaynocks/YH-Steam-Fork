extends DefaultFireball

onready var hbox = $Hitbox
var force = 0.35
var attack_force = 10
	
func on_got_blocked_by(obj):
	.on_got_blocked_by(obj)
	
	if obj == host.get_opponent():
		var pos = host.get_owner().get_pos()
		var opos = obj.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		
		obj.reset_momentum()
		obj.apply_force(str(vec.x * -attack_force), str(vec.y * -attack_force))
		
		host.disable()
	
#	--
func _tick():
	
	if current_tick > 10:
		var di = Vector2(host.get_owner().current_di.x, host.get_owner().current_di.y).normalized()
		host.apply_force(str(di.x * force), str(di.y * force))
		
	if is_instance_valid(hbox):
		var pos = host.get_owner().get_pos()
		var opos = host.get_opponent().get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()

		hbox.dir_x = vec.x * host.get_facing_int()
		hbox.dir_y = vec.y
		hbox.knockback = -attack_force
