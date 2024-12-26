extends Node2D

@export var draw_color: Color = Color.YELLOW
@export var enable_manual_interpolation: bool = false

@onready var _physics_frame_start_position: Vector2 = self.position
@onready var _physics_frame_end_position: Vector2 = self.position

func _process(delta: float) -> void:
	if self.enable_manual_interpolation:
		self.position = lerp(self._physics_frame_start_position, self._physics_frame_end_position, Engine.get_physics_interpolation_fraction())
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, 16.0, self.draw_color, true)
