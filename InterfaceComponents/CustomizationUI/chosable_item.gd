extends AttachableItem
class_name ChosableItem


func _on_button_down():
	get_parent().get_parent().get_parent().pass_item_choice(item_name)


func load_upper_body_part_data(part_name):
	item_name = part_name
	$Label.text = item_name
	$TextureRect.texture = load("res://Textures/Icons/BodyParts/UpperBody/" + item_name + ".png")
	$Description.text = "body part"
	
	
func load_lower_body_part_data(part_name):
	item_name = part_name
	$Label.text = item_name
	$TextureRect.texture = load("res://Textures/Icons/BodyParts/LowerBody/" + item_name + ".png")
	$Description.text = "body part"
