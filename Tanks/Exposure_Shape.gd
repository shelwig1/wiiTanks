extends MeshInstance3D

const TEST_MATERIAL = preload("res://Objects/test_material.tres")
# Make it accessible to the Danger_Zone calculator
var vertices = []

func _ready():
	pass
	
	"vertices.push_back(Vector3(0, 0, -100))
	vertices.push_back(Vector3(100, 0, 0))
	vertices.push_back(Vector3(0, -0, 100))"	
"
	vertices.push_back(Vector3(176.6211, 5, 101.9722))
	vertices.push_back(Vector3(-176.6211, 5, 101.9722))
	vertices.push_back(Vector3(-0, 5, -58.21865))
	


	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	
	self.add_child(m)"
	#update_mesh()

func _process(delta):
	pass


