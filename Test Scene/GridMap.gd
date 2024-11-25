extends GridMap

const EXPOSED = preload("res://Exposure Grid Materials/exposed.tres")
const RAY_EXPOSURE = preload("res://Exposure Grid Materials/ray_exposure.tscn")
@onready var ground = $".."
const material_exposed = preload("res://Exposure Grid Materials/exposed.tres")
@onready var material_safe = $"res://Exposure Grid Materials/safe.tres"
# Called when the node enters the scene tree for the first time.
func _ready():
	#var terrain_size = Vector3(ground.get_aabb().size)
	var terrain_size = ground.get_aabb().size
	var grid_size = Vector2(terrain_size.x / cell_size.x, terrain_size.z / cell_size.z)

	create_grid(grid_size, cell_size)
	#create_grid_invisible(grid_size, cell_size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_grid(grid_size, cell_size):
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var cell = MeshInstance3D.new()
			cell.mesh = PlaneMesh.new()
			cell.mesh.size = Vector2(cell_size.x, cell_size.y)
			"var material = StandardMaterial3D.new()
			#material.albedo_color = Color(randf(), randf(), randf())
			
			material.albedo_color = Color(0, 0, 1, 0.5)
			material.set_transparency(BaseMaterial3D.TRANSPARENCY_ALPHA)
			material.set_blend_mode(StandardMaterial3D.BLEND_MODE_MIX)  
			cell.material_override = material		"	
			
			cell.material_override = material_exposed
			
			cell.set_position(Vector3(x * cell_size[0] - 200, 0, y * cell_size[0] - 100))
			add_child(cell)

func create_grid_invisible(grid_size, cell_size):
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var cell = MeshInstance3D.new()
			cell.set_position(Vector3(x * cell_size[0] - 200, 0, y * cell_size[0] - 100))
			add_child(cell)
			print("created cell")
	
# 
func flood_fill():
	pass
