extends Node2D

@export var debug_label: Label
@export var manually_interpolate_all_bones: bool = false

func _process(delta: float) -> void:
	self.debug_label.text = str(
		"Engine physics_interpolation: {0}\n".format({0: get_tree().physics_interpolation}),
		"physics_ticks_per_second: {0}\n".format({0: Engine.physics_ticks_per_second}),
		"max_physics_steps_per_frame: {0}\n".format({0: Engine.max_physics_steps_per_frame}),
		"frames_per_second: {0}\n".format({0: Engine.get_frames_per_second()}),
		"manual interpolation enabled: {0}".format({0: self.manually_interpolate_all_bones})
	)

func _on_button_pressed() -> void:
	self.manually_interpolate_all_bones = !self.manually_interpolate_all_bones
	for bone in get_tree().get_nodes_in_group("sway_bones"):
		bone.enable_manual_interpolation = self.manually_interpolate_all_bones
