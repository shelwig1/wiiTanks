extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var edges = find_perpendicular_edges_box(self)
	for i in edges:
		print(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func find_perpendicular_edges_box(box: MeshInstance3D) -> Array:
	var perpendicular_edges = []	
	# Get the box's dimensions (this assumes you have a scaled box mesh)
	var size = box.scale  # Assuming the scale is uniform (1, 1, 1)
	
	# Define the corners of the box (8 points in 3D space)
	var corners = [
		Vector3(-size.x / 2, -size.y / 2, -size.z / 2),  # Front-bottom-left
		Vector3(size.x / 2, -size.y / 2, -size.z / 2),   # Front-bottom-right
		Vector3(size.x / 2, -size.y / 2, size.z / 2),    # Back-bottom-right
		Vector3(-size.x / 2, -size.y / 2, size.z / 2),   # Back-bottom-left
		Vector3(-size.x / 2, size.y / 2, -size.z / 2),   # Front-top-left
		Vector3(size.x / 2, size.y / 2, -size.z / 2),    # Front-top-right
		Vector3(size.x / 2, size.y / 2, size.z / 2),     # Back-top-right
		Vector3(-size.x / 2, size.y / 2, size.z / 2)     # Back-top-left
	]
	
	# Define the edges (pairs of corner indices)
	var edges = [
		[0, 1], [1, 2], [2, 3], [3, 0],  # Bottom face
		[4, 5], [5, 6], [6, 7], [7, 4],  # Top face
		[0, 4], [1, 5], [2, 6], [3, 7]   # Vertical edges
	]
	
	# Check for vertical edges (perpendicular to the floor)
	for edge in edges:
		var start = corners[edge[0]]
		var end = corners[edge[1]]
		
		# Vertical edges are those where x and z are the same, and only y changes
		if start.x == end.x and start.z == end.z:
			perpendicular_edges.append([start, end])

	return perpendicular_edges
