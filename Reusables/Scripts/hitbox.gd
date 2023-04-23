extends Area3D
class_name Hitbox

signal hitbox_hit(body)

@export var weakspot := 1.0
@export var invincible_duration := .3

var invin_timer := .0

func _ready():
	
	area_entered.connect(hit)
	set_physics_process(false)
	

func _physics_process(delta):
	
	invin_timer += delta
	if invin_timer >= invincible_duration:
		
		invin_timer = 0
		set_physics_process(false)
		
	

func hit(body):
	
	if body is Hitbox or invin_timer > 0:
		
		return
		
	
	set_physics_process(true)
	hitbox_hit.emit(body, self)
	
