extends Node3D

@onready var radar = $Radar
@onready var exposure_shape = $Exposure_Shape
@onready var radar_2 = $Radar2
@onready var radar_3 = $Radar3
@onready var radar_4 = $Radar4

@onready var marker = preload("res://Objects/Marker.tscn")
@onready var marker_green = preload("res://Objects/marker_green.tscn")

var timer : float = 0.0
var delay_time : float = .01
var index : int = 0

var marker_count : int = 0
var coords = PackedVector3Array()

var radar_coords_1 = PackedVector3Array()
var radar_coords_2 = PackedVector3Array()
var radar_coords_3 = PackedVector3Array()
var radar_coords_4 = PackedVector3Array()

var lastSweep

var radars = [radar, radar_2, radar_3, radar_4]
var radar_coords = [radar_coords_1, radar_coords_2, radar_coords_3, radar_coords_4]

func _ready():
	pass # Replace with function body.


func _process(delta):
	timer += delta
	
	if timer >= delay_time:
		if radar.is_colliding():
			var point = radar.get_collision_point()
			marker_count += 1
			coords.push_back(to_local(point))
				
		if radar_2.is_colliding():
			var point2 = radar_2.get_collision_point()
			radar_coords_2.push_back(to_local(point2))
		
		if radar_3.is_colliding():
			var point3 = radar_3.get_collision_point()
			radar_coords_3.push_back(to_local(point3))
		
		if radar_4.is_colliding():
			var point4 = radar_4.get_collision_point()
			radar_coords_4.push_back(to_local(point4))
		
		if marker_count == 900:
				#Combine the two arrays
			coords.append_array(radar_coords_2)
			coords.append_array(radar_coords_3)
			coords.append_array(radar_coords_4)
			
			make_mesh(coords)
			coords.clear()
			radar_coords_2.clear()
			radar_coords_3.clear()
			radar_coords_4.clear()
			marker_count = 0 
			timer = 0
			
		radar.rotation_degrees.y -= 0.1
		radar_2.rotation_degrees.y -= 0.1
		radar_3.rotation_degrees.y -= 0.1
		radar_4.rotation_degrees.y -= 0.1

		
	
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
	"m.mesh = arr_mesh
	m.top_level = true
	self.add_child(m)"
	
	lastSweep = m
	
	"if exposure_shape.mesh != null:
		exposure_shape.mesh = null
	
	exposure_shape.mesh = arr_mesh"
	exposure_shape.mesh = arr_mesh
	
	coords = []

