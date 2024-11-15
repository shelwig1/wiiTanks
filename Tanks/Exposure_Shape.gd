extends MeshInstance3D

# Make it accessible to the Danger_Zone calculator
var vertices = []

func _ready():
	"vertices = [
		Vector3(0,0,0)
	]"
	
	for i in range(36):
		if i < 10:
			vertices.append(Vector3(30,0,30))
		if i >= 10 and i < 25:
			vertices.append(Vector3(0,0,30))
		else:
			vertices.append(Vector3(30,0,0))
	
	update_mesh()

func _process(delta):
	pass

func update_vertex(location : Vector3, index : int) -> void:
	vertices[index] = location
	update_mesh()
	print("Updated ", index, " with location ", location)

func update_mesh() -> void:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	for vertex in vertices:
		st.add_vertex(vertex)
		
	mesh = st.commit()
	self.mesh = mesh
