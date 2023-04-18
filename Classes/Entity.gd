extends CharacterBody3D
class_name Entity

@export var accel := 5
@export var deaccel := 8
@export var rot_spd := 5

func _ready():
	
	stats.hp_zero.connect(dead)
	

## Function connected to different [class Hitbox] Nodes throughout the scene to pass along when the Entity is hit
func entity_hit(atk_area, hit_area):
	
	stats.take_dmg(atk_area, hit_area)
	

func dead(attacker):
	
	print("dead")
	

func rotate_mesh_dir(dir, delta):
	dir = -dir
	var cross = Vector3.UP.cross(dir)
	var rot_basis = Basis(cross, Vector3.UP, dir).orthonormalized().get_rotation_quaternion()

	%Root.transform.basis = Basis(%Root.transform.basis.get_rotation_quaternion().slerp(rot_basis, delta * rot_spd))
	
