extends Node2D

@export var draw_color: Color = Color.YELLOW
@export var frequency: float = 32
@export var amplitude: float = 128.0

@onready var _initial_position: Vector2 = self.position
@onready var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _last_global_position: Vector2 = self.global_position
var _sway_direction: float

func _ready() -> void:
	# Initialize a new fixed-seed RNG for consistent sway every time the scene runs.
	self._rng.set_seed(0xEEFF0C - hash(self.name))
	
	# Generate a random angle to use as the direction for this bone to sway along.
	self._sway_direction = self._rng.randf_range(0, 2 * PI)
	
func _physics_process(delta: float) -> void:
	# Translate the bone with a sine-wave-based sway motion
	var sway_amount: float = sin((Time.get_ticks_msec() / 10000.0 * self.frequency))
	self.position = self._initial_position + Vector2(sway_amount, sway_amount) * Vector2.from_angle(self._sway_direction) * self.amplitude * (1 - delta)
	
func _draw() -> void:
	# Draw a circle at this node's position.
	draw_circle(Vector2.ZERO, 16.0, self.draw_color, true)
