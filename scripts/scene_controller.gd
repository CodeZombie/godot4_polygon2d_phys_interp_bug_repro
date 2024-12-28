extends Node2D

@export var debug_label: Label

func _process(delta: float) -> void:
	self.debug_label.text = str(
		"Engine physics_interpolation: {0}\n".format({0: get_tree().physics_interpolation}),
		"physics_ticks_per_second: {0}\n".format({0: Engine.physics_ticks_per_second}),
		"max_physics_steps_per_frame: {0}\n".format({0: Engine.max_physics_steps_per_frame}),
		"frames_per_second: {0}".format({0: Engine.get_frames_per_second()}),
	)
