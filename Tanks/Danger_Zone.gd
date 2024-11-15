extends Node3D

@onready var radar = $Radar
@onready var exposure_shape = $Exposure_Shape

var timer : float = 0.0
var delay_time : float = 0.05
var index : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#Make radar look at the zero rotation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer += delta
	
	if index > 35:
		index = 0
	
	if timer >= delay_time:
		if radar.is_colliding():
			exposure_shape.update_vertex(radar.get_collision_point(), index)
			
		print("Radar rotation: ", radar.rotation_degrees.y)
		radar.rotation_degrees.y += 10
		timer = 0
		index += 1

# sweep the ray cast around every X seconds
	#predefine the angels we care about
	
# Use the points we hit to redefine that part of the shape

# make a mesh with X number of points - the number is constant, because the radar only goes to x number of fixed points

# when we get the point, go into the mesh and change that
