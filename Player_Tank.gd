extends CharacterBody3D

@onready var camera = $"../Camera3D"
@onready var turret_guide = $Turret/Turret_Guide
@onready var barrel = $Turret/Direction_Arrow/Barrel
@onready var tank_body = $Tank_Body
@onready var animation_player = $AnimationPlayer


@onready var projectile = preload("res://Projectiles/projectile.tscn")

var SPEED = 30
var speed_reset = 30



@export var TANK_BODY_ROTATION_SPEED = 1

var target_tank_body_rotation = 0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var active_projectiles = 0
var max_active_projectiles = 3


func _physics_process(delta):	

	tank_body.rotation_degrees.y = wrapf(tank_body.rotation_degrees.y, 0, 360)

	
	if not is_on_floor():
		velocity.y -= gravity * delta

	"Player input portion"
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	"Handles direction - how would AI handle direction shit?"
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
	
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	active_projectiles = barrel.get_child_count()
	
	if direction == Vector3(0,0,-1):
		target_tank_body_rotation = 0.0
	
	if direction == Vector3(0,0,1):
		target_tank_body_rotation = 180.0
	
	if direction == Vector3(1,0,0):
		target_tank_body_rotation = 270
	
	if direction == Vector3(-1,0,0):
		target_tank_body_rotation = 90.0
	
	if direction[0] > 0 and direction[2] < 0:
		print('north east')
		target_tank_body_rotation = 315.0	
	if direction[0] > 0 and direction[2] > 0:
		target_tank_body_rotation = 225.0
		print('south east')
	
	if direction[0] < 0 and direction[2] > 0:
		target_tank_body_rotation = 135.0
		print('south west')
	
	if direction[0] < 0 and direction[2] < 0:
		target_tank_body_rotation = 45.0
		print('north west')
	
	else:
		pass

	if tank_body.rotation.y != target_tank_body_rotation:
		tank_body.rotation.y = lerp_angle(tank_body.rotation.y, deg_to_rad(target_tank_body_rotation), TANK_BODY_ROTATION_SPEED * delta)		
		#need_to_rot = true
		
	#if need_to_rot:
		#SPEED = 0 
	#	tank_body.rotation.y = lerp_angle(tank_body.rotation.y, deg_to_rad(target_tank_body_rotation), TANK_BODY_ROTATION_SPEED * delta)
	
	#if abs(tank_body.rotation_degrees.y - target_tank_body_rotation) < 4 and tank_body.rotation_degrees.y != target_tank_body_rotation:
	#	need_to_rot = false
		#SPEED = speed_reset
	

func _input(event):
	if Input.is_action_just_pressed('shoot'):
		if active_projectiles < max_active_projectiles:
			animation_player.play('shoot')
			var p = projectile.instantiate()
			barrel.add_child(p)
			p.rotation = $Turret.rotation
			p.shoot()

func stop_movement():
	SPEED = 0
	print('stop movement triggered')
	
func start_movement():
	SPEED = speed_reset
	print('start movement triggered')
