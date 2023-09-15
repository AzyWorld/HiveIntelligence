extends Area2D

export var moving = false

var r = RandomNumberGenerator.new()

func _ready():
	r.randomize()
	rotation_degrees = r.randi_range(0, 360)

func _process(delta):
	if moving:
		if rotation_degrees > 360:
			rotation_degrees = 0 + rotation_degrees - 360
		if rotation_degrees < 0:
			rotation_degrees = 360 + rotation_degrees
		r.randomize()
		rotation_degrees += r.randf_range(-2, 2)
	
		position += Vector2(0, -1).rotated(rotation)

func _on_Resource_area_entered(area):
	if area.is_in_group("wall"):
		rotation_degrees += 180
