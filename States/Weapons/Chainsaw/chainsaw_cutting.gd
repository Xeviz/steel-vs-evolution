extends State
class_name ChainsawCutting


@export var chainsaw : Chainsaw
@onready var time_to_cut = chainsaw.cut_interval

func enter():
	time_to_cut = chainsaw.cut_interval
	print("cuttuje")

func update(delta: float):
	time_to_cut -= delta
	if time_to_cut <= 0:
		time_to_cut = chainsaw.cut_interval
		chainsaw.deal_damage_in_area()
