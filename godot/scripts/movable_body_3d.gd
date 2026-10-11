@abstract
class_name MovableBody3D extends CharacterBody3D

@export var character_name: StringName = &"None"
@export_group("movement")
@export var max_velocity: float = 10.0
@export_range(0.1, 5.0) var accel_time: float = 2.0
@export_range(0.1, 5.0) var decel_time: float = 2.0
@onready var accel_velocity: float = max_velocity / accel_time
@onready var decel_velocity: float = max_velocity / decel_time
@export_subgroup("Jump", "jump_")
@export var jump_velocities: PackedFloat32Array = [8.0, 6.0]
@export var jump_cooldown: float = 0.25
@export var jump_on_cooldown: bool 
@onready var jump_max: int = jump_velocities.size()
@onready var jump_left: int = jump_max
@export_group("Attacks")
@export var attacks: Array[AttackResource]
@onready var has_attacks: bool = attacks.size()

var direction: Vector2
var speed: float
var jumping: bool
var can_jump: bool = true 
var current_attack: AttackResource

func _physics_process(delta: float) -> void:
	if self.is_on_floor():
		jump_left = jump_max
		can_jump = true #this is useful on jump on cooldown
	else:
		velocity.y += get_gravity().y * delta

	if jumping and jump_left and can_jump:
		velocity.y = jump_velocities[jump_max - jump_left]
		jump_left -= 1
		wait_jump_cooldown()
	
	if direction:
		speed = clampf(speed + accel_velocity * delta, 0.0, max_velocity)
		velocity.x = direction.x * speed
		velocity.z = direction.y * speed
	else:
		speed = 0
		velocity.x = move_toward(velocity.x, 0, decel_velocity * delta)
		velocity.z = move_toward(velocity.z, 0, decel_velocity * delta)
	move_and_slide()

func wait_jump_cooldown() -> void:
	can_jump = jump_on_cooldown
	await get_tree().create_timer(jump_cooldown).timeout
	can_jump = not jump_on_cooldown
