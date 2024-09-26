extends Label3D
class_name DamageLabel

var time_to_hide = 0

func _process(delta: float) -> void:
	time_to_hide-=delta
	if time_to_hide<0:
		self.hide()
		

func display_damage(value):
	text = str(value)
	print("hi " + text)
	time_to_hide = 1
	self.show()
