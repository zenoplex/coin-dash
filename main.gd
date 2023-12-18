extends Node

@export var coin_scene: PackedScene
@export var play_time: int = 30

var level: int = 1
var score: int = 0
var time_left: int = 0
var screensize: Vector2 = Vector2.ZERO
var playing: bool = false

func _ready() -> void:
	playing = true
	level = 1
	score = 0
	time_left = play_time
	screensize = get_viewport().get_visible_rect().size
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spawn_coins()

func spawn_coins() -> void:
	for i in level + 4:
		var node:Node = coin_scene.instantiate()
		node.screensize = screensize
		node.position = Vector2(randi_range(0, int(screensize.x)), randi_range(0, int(screensize.y)))
		add_child(node);

