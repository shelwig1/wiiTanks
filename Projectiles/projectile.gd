extends RigidBody3D

@export var projectile_data: projectile_type
@onready var mesh = $MeshInstance3D

#var shoot = false
var speed = 80

var number_of_bounces = 2
var max_velocity

var on = false

var collision_count = 0

func _ready():
	#self.rotation = Vector3(0,0,0)
	#var direction3d = self.rotation
	var direction3d = self.position
	
	max_velocity = direction3d * speed
	#print(max_velocity)
	#print(max_velocity.length())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	#print(self.linear_velocity.length())
	#print(self.linear_velocity)
	mesh.look_at(self.linear_velocity, Vector3(0,0,1))

	if on and self.linear_velocity.length() < speed:
		apply_impulse(self.linear_velocity * speed/10000, -transform.basis.z)
		
	#var collision_info = move_and_collide(self.linear_velocity * delta)
	#if collision_info:
	#	self.linear_velocity = self.linear_velocity.bounce(collision_info.get_normal())
	#print(self.linear_velocity)	
	pass


func shoot():
	apply_impulse(transform.basis.z * -speed * 1.5 , -transform.basis.z)
	on = true

	
func hit_something():	
	queue_free()

func die():
	print('projectile dying')
	queue_free()

func _on_body_entered(body):
	collision_count += 1
	if collision_count >= number_of_bounces:
		die()
	else:
		pass
	print('collided with something')
	pass # Replace with function body.
