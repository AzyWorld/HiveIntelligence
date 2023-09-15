extends Node2D

onready var a = preload("res://scenes/Ant.tscn").instance()
var r = RandomNumberGenerator.new()

func _ready():
	for i in range(200):
		a = preload("res://scenes/Ant.tscn").instance()
		r.randomize()
		a.position.x = r.randi_range(200, 800)
		r.randomize()
		a.position.y = r.randi_range(100, 500)
		add_child(a)
