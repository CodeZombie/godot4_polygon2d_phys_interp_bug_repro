extends Node2D

@export var debug_label: Label
@export var bones: Array[Bone2D] = []
@export var sway_speed: float = 250.0
@export var sway_amount: float = 10.0
@export var manually_interpolate_all_bones: bool = false

var _rng: RandomNumberGenerator
var _sway_offsets: Array[Vector2] = []

func _ready() -> void:
	# Initialize a new fixed-seed RNG for consistent sway every time the game runs.
	self._rng = RandomNumberGenerator.new()
	self._rng.set_seed(0xEEFF0C)
	
	# create a sway_offset for each bone so they all sway at different phases.
	for i in range(len(self.bones)):
		self._sway_offsets.append(
			Vector2(
				self._rng.randf_range(-32, 32),
				self._rng.randf_range(-32, 32)
			)
		)

func _process(delta: float) -> void:
	self.debug_label.text = str(
		"physics_interpolation: {0}\n".format({0: get_tree().physics_interpolation}),
		"physics_ticks_per_second: {0}\n".format({0: Engine.physics_ticks_per_second}),
		"max_physics_steps_per_frame: {0}\n".format({0: Engine.max_physics_steps_per_frame}),
		"frames_per_second: {0}\n".format({0: Engine.get_frames_per_second()}),
		"manual interpolation enabled: {0}".format({0: self.manually_interpolate_all_bones})
	)


func _physics_process(delta: float) -> void:
	"""
	Sway each bone's local position using a sine wave function
	"""
	
	var time: float = (Time.get_ticks_msec() * (self.sway_speed / 1000.0))
	
	for i in range(len(self.bones)):
		# Store each bone's position prior to translation
		bones[i]._physics_frame_start_position = bones[i].position
		
		bones[i].transform = bones[i].transform.translated(
			Vector2(
				sin(self._sway_offsets[i].x + time) * self.sway_amount * delta, 
				sin(self._sway_offsets[i].y + time) * self.sway_amount * delta, 
		))
		
		# Store each bone's position after translation
		bones[i]._physics_frame_end_position = bones[i].position


func _on_button_pressed() -> void:
	self.manually_interpolate_all_bones = !self.manually_interpolate_all_bones
	for bone in self.bones:
		bone.enable_manual_interpolation = self.manually_interpolate_all_bones
