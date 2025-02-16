extends Area3D

func _on_body_entered(body: Node3D) -> void:
	# Ignore all bodies that are not in the player group
	if not body.is_in_group("player"):
		return

	# Only increase the player's health if it is less than 100
	if body.player_health >= 100:
		print("Player health is full, cannot pick up health")
		return

	# Increase the player's health by 10
	body.player_health += 10
	print("Player picked up health, now at: ", body.player_health)
	queue_free()
