extends Entity
class_name Enemy

@onready var agent = $Agent
@export var spd := 5.0

var target : Node3D

func _ready():
	super()
	agent.velocity_computed.connect(pathfind_velocity)
	

func _physics_process(delta):
	
	if target:
		agent.target_position = target.global_position
	
	var next_loc = agent.get_next_path_position()
	var dir = next_loc - global_position
	dir = dir.normalized() * spd
	move_toward_target(delta)
	
	velocity = dir
	
#	prints("Vel", velocity, "Dir", dir, "Next", next_loc)
	move_and_slide()
	

## Overrides entity hit to make the player the target if they attack. 
func entity_hit(atk_area, hit_area):
	
	super(atk_area, hit_area)
	target = atk_area.owner
	

## Helper function to set the target
func set_target(tar):
	
	target = tar
	agent.target_position = target.global_position
	

## Sets the velocity to move toward the target based off the pathfinding positions
func move_toward_target(delta):
	
	if !target:
		
		return
		
	
	agent.target_position = target.global_position
#	print("Target Global", target.global_position)
	
	if agent.is_navigation_finished():
		
		return
	
	var target_pos = agent.get_next_path_position()
	
	var dir = (target_pos - global_position).normalized()
#	prints("Dir", dir, "Target", target_pos)
	
	rotate_mesh_dir(-dir, delta)
	
	velocity = dir * spd
	

## Function connected to the Agents velocity_computed signal to set the velocity based off of it.
func pathfind_velocity(vel):
	
	velocity = vel
	

## Check function to see if the enemy is attacking
func is_attacking():
	
	return $AnimationPlayer.is_playing()
	
