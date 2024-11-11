extends Tank

@onready var navigation_agent = $NavigationAgent3D

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
	
	var new_velocity = direction * SPEED
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	
	rotate_tank_body(delta, direction)
	check_tread()

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
