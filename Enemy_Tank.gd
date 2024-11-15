extends Tank

@onready var navigation_agent = $NavigationAgent3D
@export var ATTACK_RANGE = 30
#need to add turret control

#need to add a navigation agent into the mix
enum State {IDLE, PATROLLING, CHASING, ATTACKING}
var state = State.CHASING
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	# Do not query when the map has never synchronized and is empty.

	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	#var new_velocity: Vector3 = global_position.direction_to(next_path_position) * SPEED
	var direction = (player.global_transform.origin - global_position).normalized()
	
	direction = round_direction(direction)
	
	
	var new_velocity = direction * SPEED
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	
	rotate_tank_body(delta, direction)
	check_tread()

func round_direction(direction: Vector3) -> Vector3:
	# 1, 0, .7 and their negatives
	
	for i in range(3):
		# curr_val is always positive now
		var value = direction[i]
		
		var options = [-1.0, -0.7, 0.0, 0.7, 1.0]
		var closest = options[0]
		var min_difference = abs(value - closest)

		for option in options:
			var difference = abs(value - option)
			if difference < min_difference:
				closest = option
				min_difference = difference

		direction[i] =  closest
	
	return direction
		

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	
	move_and_slide()
	
func _process(delta):
	# Need to define player's current position
	match state:
		State.IDLE:
			idle_behavior()
		State.PATROLLING:
			patrolling_behavior()
		State.CHASING:
			#print("Enemy is chasing")
			chasing_behavior(delta)
		State.ATTACKING:
			attacking_behavior()
			
func idle_behavior():
	pass
	
func patrolling_behavior():
	pass
	
func chasing_behavior(delta):
	"Fix this - don't know how to move_toward something"
	#move_toward(self.position, player.position, delta)
	set_movement_target(player.global_transform.origin)

	"if position.distance_to(player.position) < attack_range:
		state = State.ATTACKING"
	
func attacking_behavior():
	pass
