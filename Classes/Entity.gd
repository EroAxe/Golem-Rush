extends CharacterBody3D
class_name Entity

@export_group("Data")
@export var stats : Stats = Stats.new()
@export var attacks : Array[Attack]
@export_group("Movement Values")
@export var accel := 5
@export var deaccel := 8
@export var rot_spd := 5
@export_group("Extra")
@export var label_offset := 4
@export var root : Node3D
@export var anim_tree : AnimationTree
@export var info_label_spawn : Node3D

@onready var anim_playback : AnimationNodeStateMachinePlayback = anim_tree["parameters/playback"]

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

	root.transform.basis = Basis(root.transform.basis.get_rotation_quaternion().slerp(rot_basis, delta * rot_spd))
	

func attack(attack, atk_box):
	
#	AnimationTree Travel Shenanigans
	anim_playback.travel(attack.anim)
	attack.reset_cooldown()
	attack.sender = self
	atk_box.attack = attack
	
