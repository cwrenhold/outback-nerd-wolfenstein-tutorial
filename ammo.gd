extends Area3D

func _on_body_entered(body: Node3D) -> void:
	# Ignore all bodies that are not in the player group
	if not body.is_in_group("player"):
		return

	Global.ammo += 10
	print("Player picked up ammo, now at: ", Global.ammo)
	queue_free()
