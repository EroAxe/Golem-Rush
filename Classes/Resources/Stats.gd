extends Resource
class_name Stats

signal hp_zero()
signal dmg_taken()
signal blocked()

@export var hp := 5.0
@export var max_hp := 5.0
@export var dmg := 5
@export var defense := .01

func take_dmg(attack, hit_area):
	
	dmg = calc_dmg(attack.dmg, hit_area)
	
	if dmg <= 0:
		
		blocked.emit()
		
	
	hp -= dmg
	
	dmg_taken.emit(dmg)
	
	if hp <= 0:
		
		hp_zero.emit(attack.sender)
		
	

## Calculates damage with defense in mind.
func calc_dmg(dmg, hit_area):
	
	var weak_bonus = hit_area.weakspot
	
	return dmg * weak_bonus - (dmg * weak_bonus * defense)
	
