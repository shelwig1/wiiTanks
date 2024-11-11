extends Tank

@onready var camera = $"../Camera3D"
@onready var turret_guide = $Turret/Turret_Guide
const DECELERATION_FACTOR = 10

func _physics_process(delta):
		# Player input 
	var input_dir = Input.get_vector("left", "right", "up", "down")	
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# Gradually move velocity toward zero for smooth stopping
		velocity.x = move_toward(velocity.x, 0, SPEED * DECELERATION_FACTOR * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * DECELERATION_FACTOR * delta)
	
	# Move the character body

	move_and_slide()
	
	rotate_tank_body(delta, direction)
	check_tread()
	
	active_projectiles = barrel.get_child_count()
	

func _input(event):
	#Need to add user input shit into the player script, not the tank class
	if Input.is_action_just_pressed('shoot'):
		if active_projectiles < max_active_projectiles:
			animation_player.play('shoot')
			var p = projectile.instantiate()
			barrel.add_child(p)
			p.rotation = $Turret.rotation
			p.shoot()

