extends Node

var is_true = true
var is_false = false
# Called when the node enters the scene tree for the first time.
func _ready():
	print('hello')
	print(1 * is_true)
	print(1 * is_false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
