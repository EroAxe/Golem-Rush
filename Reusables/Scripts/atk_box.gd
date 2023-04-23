extends Area3D


signal attacked_target(body)

@export var attack : Attack

func _ready():
	
	body_entered.connect(attacked)
	


func ready_attack(attack):
	
	self.attack = attack
	

func attacked(body):
	
	attacked_target.emit(self)
	
