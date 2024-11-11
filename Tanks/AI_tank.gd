extends Tank


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):	
	# Input directions are meaningless, have it decided by the uhhhhhh fucking uhhhhh AI agent
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
