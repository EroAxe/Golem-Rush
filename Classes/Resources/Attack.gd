extends Resource
class_name Attack

@export var dmg := 5
@export var cooldown := 3.0
@export var anim := "String"
var cur_cooldown = cooldown: set = tick_cooldown
var sender : Entity

func tick_cooldown(new_val):
	
	cur_cooldown = new_val
	
	if cur_cooldown <= 0:
		
		print("Cooldown over")
		cur_cooldown = 0
		
	

func reset_cooldown():
	
	cur_cooldown = cooldown
	

func can_attack():
	
	return !cur_cooldown > 0
	
