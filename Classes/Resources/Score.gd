extends Resource
class_name Score

@export var time_to_beat := .0
@export var damage_taken := .0
@export var dps := .0


## Helper function for calculating out the total score based off the values saved in this resource.
func calculate_total_score():
	
	var score = check_achievements()
	
	score += dps/5 * 10
	score -= time_to_beat
	
	return score
	

func check_achievements():
	
	var achieve_bonus = 0
	
	if damage_taken <= 0:
		
		achieve_bonus += 500
		
	
	if dps >= 20:
		
		achieve_bonus += 200
		
	
	return achieve_bonus
	
