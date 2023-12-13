extends Area2D

@export var speed:int = 350;

var velocity:Vector2 = Vector2.ZERO
var screensize:Vector2 = Vector2(480, 720)

func _process(delta: float) -> void:
  velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  position += velocity * speed * delta
