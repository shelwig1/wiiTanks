extends Node3D

@onready var radar = $Radar
@onready var exposure_shape = $Exposure_Shape

@onready var marker = preload("res://Objects/Marker.tscn")
const TEST_MATERIAL = preload("res://Objects/test_material.tres")

var timer : float = 0.0
var delay_time : float = 0.01
var index : int = 0

var marker_count : int = 0
var coords = PackedVector3Array()

var lastSweep
# Called when the node enters the scene tree for the first time.
func _ready():
	#Make radar look at the zero rotation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if radar.is_colliding():
			var point = radar.get_collision_point()
			marker_count += 1
			coords.push_back(to_local(point))
	if marker_count == 720:
			make_mesh(coords)
			coords.clear()
			marker_count = 0 
			
	radar.rotation_degrees.y -= 0.5
	
	"timer += delta
	
	if timer >= delay_time:
		if radar.is_colliding():
			var point = radar.get_collision_point()
			marker_count += 1
			coords.push_back(to_local(point))
			
			
		if marker_count == 37:
			make_mesh(coords)
			coords.clear()
			marker_count = 0 

		radar.rotation_degrees.y -= 10
	
		timer = 0
	"	


func make_mesh(coords):
	print("Made mesh")
	
	if lastSweep != null:
		lastSweep.queue_free()
	
	var indices = PackedInt32Array()
	for i in range(coords.size() - 1):
		indices.push_back(i)
		indices.push_back(i + 1)
	
	# Iitialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = coords
	arrays[Mesh.ARRAY_INDEX] = indices

	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)
	
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	m.top_level = true
	self.add_child(m)
	
	lastSweep = m
	
	"if exposure_shape.mesh != null:
		exposure_shape.mesh = null
	
	exposure_shape.mesh = arr_mesh"
	
	coords = []

