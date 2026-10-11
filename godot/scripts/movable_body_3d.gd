@abstract
class_name MovableBody3D extends CharacterBody3D

@export var character_name: StringName = &"None"
@export_group("movement")
@export var max_velocity: float = 400.0
@export var accel_velocity: float = 50.0
@export var decel_velocity: float = 50.0
@export_subgroup("Jump", "jump_")
@export var jump_velocities: PackedFloat32Array = [400.0, 150.0]
@export var jump_time: float = 0.25
@export_group("Attacks")
@export var attacks: Array[AttackResource]

var direction: Vector2
var jumping: bool
var current_attack: AttackResource

@onready var jump_max: int = jump_velocities.size()
@onready var has_attacks: bool = attacks.size()

func _physics_process(delta: float) -> void:
	pass
