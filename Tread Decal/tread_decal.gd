extends Decal

@export var initial_lifetime: float
@export var decay_time: float

func _ready():
	
	await(get_tree().create_timer(initial_lifetime).timeout)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "albedo_mix", 0, decay_time)
	tween.tween_callback(self.queue_free)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#lerp the albedo mix down to zero after a given wait time
	pass
