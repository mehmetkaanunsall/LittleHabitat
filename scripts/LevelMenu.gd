class_name LevelMenu
extends Control

static var selected_category: String = "Animals"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TitleLabel.text = selected_category.to_upper() + " LEVELS"
	$Level2Button.disabled = true
	$Level3Button.disabled = true
	$Level4Button.disabled = true
	$Level5Button.disabled = true
	$Level6Button.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_level_1_button_pressed() -> void:
	print("Level 1 button clicked")

func _on_level_2_button_pressed() -> void:
	print("Level 2 button clicked")
	
func _on_level_3_button_pressed() -> void:
	print("Level 3 button clicked")

func _on_level_4_button_pressed() -> void:
	print("Level 4 button clicked")
	
func _on_level_5_button_pressed() -> void:
	print("Level 5 button clicked")
	
func _on_level_6_button_pressed() -> void:
	print("Level 6 button clicked")
