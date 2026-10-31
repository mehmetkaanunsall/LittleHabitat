
extends Control

@onready var play_again_button: Button = $PlayAgainButton
@onready var home_button: Button = $HomeButton

func _ready() -> void:
	print("VICTORY SCREEN AÇILDI")

	play_again_button.pressed.connect(_play_again)
	home_button.pressed.connect(_home)

	_responsive_layout()
	get_viewport().size_changed.connect(_responsive_layout)


func _responsive_layout() -> void:
	var ekran = get_viewport_rect().size

	var sx = ekran.x / 1280.0
	var sy = ekran.y / 720.0

	# PLAY AGAIN
	play_again_button.position = Vector2(444.0 * sx, 511.0 * sy)
	play_again_button.size = Vector2(410.0 * sx, 85.0 * sy)

	# HOME
	home_button.position = Vector2(459.0 * sx, 614.0 * sy)
	home_button.size = Vector2(360.0 * sx, 85.0 * sy)


func _play_again() -> void:
	print("PLAY AGAIN TIKLANDI")
	get_tree().change_scene_to_file("res://Game.tscn")


func _home() -> void:
	print("HOME TIKLANDI")
	get_tree().change_scene_to_file("res://MainMenu.tscn")
