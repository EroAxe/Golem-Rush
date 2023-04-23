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
	
	tick_cooldowns(delta)
	
	if !is_attacking():
		
	move_toward_target(delta)
	
	if !is_attacking():
		
		start_attack()
		
	
	move_and_slide()
	

func tick_cooldowns(delta):
	
	for all in attacks:
		
		all.cur_cooldown -= delta
		
	

func start_attack():
	
	if !target:
		
		return
		
	
	var sel_attack = select_attack(target.global_position)
	if sel_attack == null:
		
		return
		
	
	attack(sel_attack, %Atk_Box)
#	$AnimationPlayer.play(sel_attack.anim)
	

## Helper function for selecting an attack based off a target.  Returns back the first random attack within range that is off cooldown.
func select_attack(atk_target):
	
	var attack
	var ready_attacks : Array
	
	for all in attacks:
		
		if all.in_range(atk_target, global_position) and all.can_attack():
			ready_attacks.append(all)
	
	if ready_attacks.size() == 0:
		
		return
		
	
	var rand = randi() % ready_attacks.size()
	attack = ready_attacks[rand]
	
	return attack
	

## Helper function to set the target
func set_target(tar):
	
	target = tar
	agent.target_position = target.global_position
	

## Sets the velocity to move toward the target based off the pathfinding positions
func move_toward_target(delta):
	
	if !target:
		
		return
		
	
	agent.target_position = target.global_position
		
	
	var target_pos = agent.get_next_path_position()
	
	var dir = (target_pos - global_position).normalized()
	
	rotate_mesh_dir(-dir, delta)
	
	if agent.is_target_reached() or global_position.distance_to(target.global_position) < 2:
		
		anim_playback.travel("Idle")
		return
	
	anim_playback.travel("Walk")
	
	velocity = dir * spd
	

## Function connected to the Agents velocity_computed signal to set the velocity based off of it.
func pathfind_velocity(vel):
	
	velocity = vel
	

## Check function to see if the enemy is attacking
func is_attacking():
	
	return anim_playback.get_current_node() == "Attack"
	

## Overrides entity hit to make the player the target if they attack. 
func entity_hit(atk_area, hit_area):
	
	super(atk_area, hit_area)
	target = atk_area.owner
	
