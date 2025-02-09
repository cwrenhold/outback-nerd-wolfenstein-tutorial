extends CanvasLayer

var time_since_last_shot := 0.0
var fire_rate := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$AnimatedSprite2D.play(Global.current_weapon + "_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_shot += delta
	var can_shoot := time_since_last_shot >= (1.0 / fire_rate)

	if Global.current_weapon != "knife" && Global.ammo <= 0:
		Global.current_weapon = "knife"
		$AnimatedSprite2D.play("knife_idle")

	# If the player can shoot and the shoot button is pressed, shoot the weapon
	if Input.is_action_pressed("ui_select") && can_shoot:
		time_since_last_shot = 0.0
		$AnimatedSprite2D.play(Global.current_weapon + "_shoot")

		# Decrease the ammo count if the current weapon is not a knife.
		if Global.current_weapon != "knife" and Global.ammo > 0:
			Global.ammo -= 1

	match Global.current_weapon:
		"gun":
			fire_rate = 3.0
		"machine":
			fire_rate = 6.0
		"mini":
			fire_rate = 10.0
		"knife":
			fire_rate = 2.0
		# Default case, which should never be reached
		_:
			fire_rate = 1.0

func _on_AnimatedSprite2D_animation_finished() -> void:
	$AnimatedSprite2D.play(Global.current_weapon + "_idle")
