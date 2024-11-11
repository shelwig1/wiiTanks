extends MeshInstance3D

@onready var camera = $"../../Camera3D"
@onready var mouse_pos = $"../MousePos"
@onready var turret_guide = $"../Turret_Guide"


@export var TURRET_ROTATION_SPEED = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#this is where the rotation needs to happen	
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	
	var rayOrigin = camera.project_ray_origin(mouse_position)
	
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	#var ray = camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	
	var intersection = space_state.intersect_ray(query)
	
	var curr_pos = Vector2(self.transform.origin.x, self.transform.origin.z)
	#print("Current pos: ",curr_pos)
	
	if not intersection.is_empty():
		var pos = intersection.position
		var pos_processed = Vector3(pos.x,0,pos.z)
	
		
		'''LOOK AT - > no slow rotation'''
		#self.look_at(Vector3(pos.x,0,pos.z), Vector3(0,1,0))

		turret_guide.look_at(pos_processed, Vector3(0,1,0))
		var goal_turret_rotation = turret_guide.rotation
	
		#self.rotation[1] = self.rotation.lerp(goal_turret_rotation, delta * TURRET_ROTATION_SPEED)[1]	
		self.rotation.y = lerp_angle(self.rotation.y, goal_turret_rotation[1], TURRET_ROTATION_SPEED * delta)
		#lerp anlge
		
		#print(rad_to_deg(self.rotation[1]))
	
		
		mouse_pos.global_position = pos
	
	self.rotation.x = 0
	self.rotation.z = 0


