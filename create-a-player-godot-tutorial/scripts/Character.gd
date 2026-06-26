extends CharacterBody2D
const JUMP_VELOCITY = -460
var idle_time = 0.0
@export var speed: float = 155.0
var gravity_scale = 1.0
var last_facing = 1
func _ready() -> void:
	$AnimatedSprite2D.play("side_idle")



func _physics_process(delta: float) -> void:
	platformer_movement(delta)

func platformer_movement(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * gravity_scale * delta
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("Left", "Right")
	if direction != 0:
		idle_time = 0.0
		last_facing = direction
		velocity.x = direction * speed
		$AnimatedSprite2D.speed_scale = 1.0
		$AnimatedSprite2D.play("side_move")
		$AnimatedSprite2D.flip_h = direction < 0
		if direction < 0:
			$CollisionPolygon2D.scale.x = -1
		else:
			$CollisionPolygon2D.scale.x = 1

	else:
			$AnimatedSprite2D.speed_scale = 0.5
			velocity.x = move_toward(velocity.x, 0, speed)
			idle_time += delta
			if idle_time > 0.15:
				$AnimatedSprite2D.play("side_idle")
	move_and_slide()
