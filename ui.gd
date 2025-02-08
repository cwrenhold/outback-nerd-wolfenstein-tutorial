extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		if Global.current_weapon == "knife":
			$AnimatedSprite2D.play("stab")
		elif Global.current_weapon == "gun":
			if Global.ammo > 0:
				$AnimatedSprite2D.play("shoot")
				Global.ammo -= 1
			else:
				Global.current_weapon = "knife"
				$AnimatedSprite2D.play("knife_idle")

func _on_AnimatedSprite2D_animation_finished() -> void:
	if Global.current_weapon == "knife":
		$AnimatedSprite2D.play("knife_idle")
	elif Global.current_weapon == "gun":
		$AnimatedSprite2D.play("gun_idle")
