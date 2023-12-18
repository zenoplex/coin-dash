extends CanvasLayer
signal start_game

func update_score(value: int) -> void:
	$MarginContainer/Score.text = str(value)

func update_timer(value: int) -> void:
	$MarginContainer/Time.text = str(value)

func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$Timer.start()

func _on_timer_timeout() -> void:
	$Message.hide()
