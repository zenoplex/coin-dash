extends Area2D

@export var speed:int = 350;

var velocity:Vector2 = Vector2.ZERO
var screensize:Vector2 = Vector2(480, 720)

func _process(delta: float) -> void:
  velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  position += velocity * speed * delta
  position.x = clamp(position.x, 0, screensize.x)
  position.y = clamp(position.y, 0, screensize.y)

  if velocity.length() > 0:
    $AnimatedSprite2D.animation = "run"
  else:
    $AnimatedSprite2D.animation = "idle"
  
  if velocity.x != 0:
    $AnimatedSprite2D.flip_h = velocity.x < 0

func start() -> void:
  print_debug("start")
  set_process(true)
  position = screensize / 2
  $AnimatedSprite2D.animation = "idle"

func end() -> void:
  $AnimatedSprite2D.animation = "hurt"
  set_process(false)
  
