extends Entity

@export_group("Speed Values")
@export var spd := 10.0
@export var grav := 15
@export var jump_grav := 11.25
@export var jump_spd := 20.0

@export_group("Settings")
@export var mouse_sens := .01

var stats_screen := preload("res://UI/Death_Screen.tscn")

var cur_grav
var last_dir : Vector3

var dmg_taken : float
var dmg_dealt : float

func _ready():
	super()
	
	stats.hp_zero.connect(player_died)
	

func _physics_process(delta):
	
	var input = Input.get_vector("left", "right", "up", "down")
	
	var dir = Vector3(input.x, 0, input.y)
	dir = dir.rotated(Vector3.UP, %Y_Boss.rotation.y) * spd
	
	if dir.length() > .2:
		last_dir = dir
	rotate_mesh_dir(last_dir, delta)
	
	if dir:
		
		velocity.x = move_toward(velocity.x, dir.x, accel)
		velocity.z = move_toward(velocity.z, dir.z, accel)
	else:
		
		velocity.x = move_toward(velocity.x, 0, deaccel)
		velocity.z = move_toward(velocity.z, 0, deaccel)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		
		velocity.y = jump_spd
		
	
	if !is_on_floor():
		
		if velocity.y > 0:
			cur_grav = jump_grav
#			print("mid jump")
		else:
			cur_grav = grav
#			print("falling")
		
		velocity.y -= cur_grav * delta
#		prints(velocity.y, cur_grav)
	
	move_and_slide()

func _input(event):
	
	if event is InputEventMouseMotion:
		
		%Y_Boss.rotate_y(-event.relative.x * mouse_sens)
		%X_Boss.rotate_x(-event.relative.y * mouse_sens)
		
		%X_Boss.rotation.x = clamp(%X_Boss.rotation.x,  deg_to_rad(-90), deg_to_rad(0))
		
	
	if event.is_action("attack"):
		
		attack("Test_Attack", 5.0)
func show_dmg(dmg):
	super(dmg)
	
	dmg_taken += dmg
		
	

func attack(anim, dmg):
	
	%Atk_Box.dmg = dmg
	$AnimationPlayer.play(anim)
	
