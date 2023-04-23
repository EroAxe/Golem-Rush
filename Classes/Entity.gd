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
	stats.dmg_taken.connect(show_dmg)
	

## Function connected to different [class Hitbox] Nodes throughout the scene to pass along when the Entity is hit
func entity_hit(atk_area, hit_area):
	
	stats.take_dmg(atk_area.attack, hit_area)
	

func show_dmg(dmg):
	
	# Creates a label and sets it to billboard to the camera
	var label = Label3D.new()
	label.billboard = 1
	label.no_depth_test = true
	
	info_label_spawn.add_child(label)
	label.global_transform = info_label_spawn.global_transform
	label.top_level = true
	label.text = str(dmg)
	label.scale *= 3
	
	randomize()
	info_label_spawn.rotation.x = randf_range(0, 90)
	info_label_spawn.rotation.z = randf_range(0, 90)
	
	var dur = ((label.position.y + label_offset) - label.position.y) * .2
	
	var tween = create_tween()
	tween.tween_method(label.translate_object_local, Vector3.ZERO, Vector3(0, (label.position.y - label_offset)*.04, 0), dur)
#	tween.tween_callback(label.translate_object_local.bind(Vector3(0, label_offset, 0)))
#	tween.tween_property(label, "position:y", label.position.y + label_offset, dur)
	tween.parallel().tween_property(label, "modulate:a", 0, dur)
	tween.tween_callback(label.queue_free)
	

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
	
