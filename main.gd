extends Node

@export var coin_scene: PackedScene
@export var play_time: int = 30

var level: int = 1
var score: int = 0
var time_left: int = 0
var screensize: Vector2 = Vector2.ZERO
var playing: bool = false
