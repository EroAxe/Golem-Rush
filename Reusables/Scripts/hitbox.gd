extends Area3D

signal hitbox_hit(body)

@export var weakspot := 1.0

func _ready():
	
	area_entered.connect(hit)
	

func hit(body):
	
	hitbox_hit.emit(body, self)
	
