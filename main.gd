extends Node

@export var coin_scene: PackedScene
@export var powerup_scene: PackedScene
@export var play_time: int = 30

var level: int = 1
var score: int = 0
var time_left: int = 0
var screensize: Vector2 = Vector2.ZERO 
var is_playing: bool = false

func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.hide()

func _process(_delta:float) -> void:
	if is_playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()

		$PowerupTimer.wait_time = randi_range(5, 10)
		$PowerupTimer.start()
		
func _on_game_timer_timeout() -> void:
	time_left -= 1
	$HUD.update_timer(time_left)
	
	if time_left <= 0:
		game_over()
	
func _on_hud_start_game() -> void:
	new_game()

func _on_player_pickup() -> void:
	score += 1
	$HUD.update_score(score)
	$CoinSound.play()

func _on_player_hurt() -> void:
	game_over()

func _on_powerup_timer_timeout() -> void:
	var node:Node = powerup_scene.instantiate()
	node.screensize = screensize
	node.position = Vector2(randi_range(0, int(screensize.x)), randi_range(0, int(screensize.y)))
	add_child(node)
	print("Powerup spawned")

func new_game() -> void:
	is_playing = true
	level = 1
	score = 0
	time_left = play_time
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spawn_coins()	

	$HUD.update_score(score)
	$HUD.update_timer(time_left)
		
func game_over() -> void:
	is_playing = false
	# Remove all coins
	get_tree().call_group("coins", "queue_free")
	$HUD.show_game_over()
	$Player.end()
	$GameTimer.stop()
	$EndSound.play()

# Span number of coins to level
func spawn_coins() -> void:
	for i in level + 4:
		var node:Node = coin_scene.instantiate()
		node.screensize = screensize
		node.position = Vector2(randi_range(0, int(screensize.x)), randi_range(0, int(screensize.y)))
		add_child(node);
	$LevelSound.play()
	