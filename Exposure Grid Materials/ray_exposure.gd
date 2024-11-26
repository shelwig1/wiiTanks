extends RayCast3D

var player : Node3D
var parent : Node3D

const EXPOSED_MATERIAL = preload("res://Exposure Grid Materials/exposed.tres")
const SAFE_MATERIAL = preload("res://Exposure Grid Materials/safe.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	player = get_tree().get_nodes_in_group("player")[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.look_at(player.global_transform.origin)
	
	if self.is_colliding() and self.get_collider() == player:
		change_to_exposed()
		return
		
	change_to_safe()

func change_to_exposed():
	parent.material_override = EXPOSED_MATERIAL
	
func change_to_safe():
	parent.material_override = SAFE_MATERIAL
	
	
