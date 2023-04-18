extends Area3D


signal attacked_target(body)

@export var dmg := 5.0

func _ready():
	
	body_entered.connect(attacked)
	

func ready_attack(dmg):
	
	self.dmg = dmg
	

func attacked(body):
	
	attacked_target.emit(body)
	
