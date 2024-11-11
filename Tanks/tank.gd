class_name Tank
extends CharacterBody3D

'Internal References'
@onready var barrel = $Turret/Direction_Arrow/Barrel
@onready var tank_body = $Tank_Body
@onready var animation_player = $AnimationPlayer
@onready var tread_origin = $"Tank_Body/Tread Origin"
@onready var tread_origin_2 = $"Tank_Body/Tread Origin2"

'Preload projectile'
@onready var projectile = preload("res://Projectiles/projectile.tscn")
@onready var TREAD_DECAL = preload("res://Tread Decal/tread_decal.tscn")
'Movement varaibles'
@export var SPEED = 30
@export var speed_reset = 30
@export var TANK_BODY_ROTATION_SPEED = 1



'Shooting variables'
var active_projectiles = 0
@export var max_active_projectiles = 3

var can_decal = true

var target_tank_body_rotation = 0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# We can just check if it's a player tank, have it properly handle inputs if it is

func _physics_process(delta):	
	print("Tank class physics process working")
	#Sets the rotation values between 0 and 360 to make math easier

	if not is_on_floor():
		velocity.y -= gravity * delta


"	if velocity != Vector3(0,0,0) and can_decal:
		leave_tread(tread_origin)
		leave_tread(tread_origin_2)
		can_decal = false
		await(get_tree().create_timer(0.3).timeout)
		can_decal = true"

func rotate_tank_body(delta, direction):
	tank_body.rotation_degrees.y = wrapf(tank_body.rotation_degrees.y, 0, 360)
	
	if direction == Vector3(0,0,-1):
		target_tank_body_rotation = 0.0
	
	if direction == Vector3(0,0,1):
		target_tank_body_rotation = 180.0
	
	if direction == Vector3(1,0,0):
		target_tank_body_rotation = 270
	
	if direction == Vector3(-1,0,0):
		target_tank_body_rotation = 90.0
	
	if direction[0] > 0 and direction[2] < 0:
		target_tank_body_rotation = 315.0	
	if direction[0] > 0 and direction[2] > 0:
		target_tank_body_rotation = 225.0
	
	if direction[0] < 0 and direction[2] > 0:
		target_tank_body_rotation = 135.0
	
	if direction[0] < 0 and direction[2] < 0:
		target_tank_body_rotation = 45.0
	
	else:
		pass

	if tank_body.rotation.y != target_tank_body_rotation:
		tank_body.rotation.y = lerp_angle(tank_body.rotation.y, deg_to_rad(target_tank_body_rotation), TANK_BODY_ROTATION_SPEED * delta)	
	

func check_tread():
	if velocity != Vector3(0,0,0) and can_decal:
		leave_tread(tread_origin)
		leave_tread(tread_origin_2)
		can_decal = false
		await(get_tree().create_timer(0.3).timeout)
		can_decal = true

func leave_tread(node):
	var tread = TREAD_DECAL.instantiate()
	node.add_child(tread)
	tread.reparent(self.get_parent())
	tread.rotation = tank_body.rotation
	tread.position.y = tread.get_parent().position.y
	
func stop_movement():
	SPEED = 0
	print('stop movement triggered')
	
func start_movement():
	SPEED = speed_reset
	print('start movement triggered')
