extends Attack
class_name AI_Attack

@export var range := 5.0

func in_range(atk_target : Vector3, owner_pos : Vector3):
	
	return owner_pos.distance_to(atk_target) <= range
	
