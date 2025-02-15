extends CharacterBody3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")

const SPEED = 5.0
var dead := false
var is_attacking := false
var attack_range := 20.0

func _ready() -> void:
	add_to_group("guard")

func _physics_process(delta: float) -> void:
	# If the guard is busy, nothing needs to be done
	if dead or is_attacking:
		return

	# If the player is not in the scene, nothing needs to be done
	if player == null:
		return

	# Move towards the player
	var direction = player.global_position - global_position
	direction.y = 0
	direction = direction.normalized()
	velocity = direction * SPEED

	# Add some gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	look_at(player.global_position)
	move_and_slide()
	attack()

func attack() -> void:
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player > attack_range:
		return

	is_attacking = true
	$AnimatedSprite3D.play("shoot")

	if $RayCast3D.is_colliding() and $RayCast3D.get_collider().has_method("damage"):
		$RayCast3D.get_collider().damage()

	# Wait for the animation to finish, then reset the state
	await $AnimatedSprite3D.animation_finished
	is_attacking = false

func die() -> void:
	dead = true
	$AnimatedSprite3D.play("die")
	$CollisionShape3D.disabled = true
