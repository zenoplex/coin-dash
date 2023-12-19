extends Area2D

var screensize:Vector2 = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.frame = randi_range(0, $AnimatedSprite2D.sprite_frames.get_frame_count("default"))
	$AnimatedSprite2D.play()

func pickup() -> void:
	# Wait for the current frame to finish
	$CollisionShape2D.set_deferred("disabled", true)
	var tween:Tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "scale", scale * 3, 0.3)
	# modulate:a refers to the alpha value of the color
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	queue_free()

func _on_area_entered(area:Area2D) -> void:
	# If the coin is overlapping obstacles move it to a new position
	if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, int(screensize.x)), randi_range(0, int(screensize.y)))
	