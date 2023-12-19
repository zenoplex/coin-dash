extends Area2D

func pickup() -> void:
	# Wait for the current frame to finish
	$CollisionShape2D.set_deferred("disabled", true)
	var tween:Tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "scale", scale * 3, 0.3)
	# modulate:a refers to the alpha value of the color
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	queue_free()

func _on_lifetime_timeout() -> void:
	queue_free()
