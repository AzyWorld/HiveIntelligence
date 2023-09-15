extends Area2D

signal Steps

var r = RandomNumberGenerator.new()

var target = true

var StepsToRes = 0
var StepsToBase = 0

var antsFarMe = []

var speed

func _ready():
	r.randomize()
	speed = r.randf_range(-6.0, -4.0)
	r.randomize()
	if r.randi_range(0, 100)<50:
		target = true
	else:
		target = false
	r.randomize()
	rotation_degrees = r.randi_range(0, 360)

func _process(_delta):
	if target:
		$Polygon2D.color = Color(0, 1, 0)
	else:
		$Polygon2D.color = Color(1, 0,0 )
		
	if rotation_degrees > 360:
		rotation_degrees = 0 + rotation_degrees - 360
	if rotation_degrees < 0:
		rotation_degrees = 360 + rotation_degrees
		
#	for i in get_overlapping_areas():
#		if i.is_in_group("ant"):
#			if (not is_connected("Steps", i, "MySteps")) or (not (i.is_connected("Steps", self, "MySteps"))):
#				antsFarMe.append(i)
#				i.connect("Steps", self, "MySteps")
#	for i in antsFarMe:
#		if not (i in get_overlapping_areas()):
#			i.disconnect("Steps", self, "MySteps")
#			antsFarMe.remove(antsFarMe.find(i))
	
	
	r.randomize()
	rotation_degrees += r.randi_range(-7, 7)
	
	position += Vector2(0, speed).rotated(rotation)
	StepsToBase += 5
	StepsToRes += 5

func MySteps(otherBase, otherRes, pos):
	if (otherBase+32*$CollisionShape2D.scale.x) < StepsToBase:
		StepsToBase = otherBase+32*$CollisionShape2D.scale.x
		if not target:
			look_at(pos)
			rotation_degrees += 90
	if (otherRes+32*$CollisionShape2D.scale.x) < StepsToRes:
		StepsToRes = otherRes+32*$CollisionShape2D.scale.x
		if target:
			look_at(pos)
			rotation_degrees += 90

func _on_body_area_entered(area):
	if area.is_in_group("wall"):
		rotation_degrees += 180
	if area.is_in_group("queen"):
		StepsToBase = 0
		rotation_degrees += 180
		if not target:
			target = true
		emit_signal("Steps", StepsToBase, StepsToRes, position)
	if area.is_in_group("res"):
		StepsToRes = 0
		rotation_degrees += 180
		if target:
			target = false
		emit_signal("Steps", StepsToBase, StepsToRes, position)


func _on_Timer_timeout():
	for i in get_overlapping_areas():
		if i.is_in_group("ant"):
			MySteps(i.StepsToBase, i.StepsToRes, i.position)
