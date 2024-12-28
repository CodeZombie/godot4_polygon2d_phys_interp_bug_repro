extends Node2D

@export var draw_color: Color = Color.YELLOW
@export var frequency: float = 32
@export var amplitude: float = 256.0
@export var enable_manual_interpolation: bool = false

@onready var _initial_position: Vector2 = self.position
@onready var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var _physics_frame_start_position: Vector2 = self.position
@onready var _physics_frame_end_position: Vector2 = self.position
var _last_global_position: Vector2 = self.global_position
var _sway_direction: float

func _ready() -> void:
	# Initialize a new fixed-seed RNG for consistent sway every time the scene runs.
	self._rng.set_seed(0xEEFF0C - hash(self.name))
	
	# Generate a random angle to use as the direction for this bone to sway along.
	self._sway_direction = self._rng.randf_range(0, 2 * PI)
	
func _process(delta: float) -> void:
	# MANUAL INTERPOLATION: Perform manual position interpolation based on the start/end-position values from the last physics_process call
	if self.enable_manual_interpolation:
		self.position = lerp(self._physics_frame_start_position, self._physics_frame_end_position, Engine.get_physics_interpolation_fraction())
	
	queue_redraw()
	
func _physics_process(delta: float) -> void:
	"""
	Sway each bone's local position using a sine wave function
	"""
	
	# MANUAL INTERPOLATION: Store the position prior to translation.
	self._physics_frame_start_position = self.position
	
	# Translate the bone with a sine-wave-based sway motion
	var sway_amount: float = sin((Time.get_ticks_msec() / 10000.0 * self.frequency))
	self.position = self._initial_position + Vector2(sway_amount, sway_amount) * Vector2.from_angle(self._sway_direction) * self.amplitude * delta
	
	# MANUAL INTERPOLATION: Store the position after translation
	self._physics_frame_end_position = self.position
	
func _draw() -> void:
	# Draw the position of this node because some nodes (Bone2D for example)
	# dont have a visual representation in-game.
	draw_circle(Vector2.ZERO, 16.0, self.draw_color, true)
