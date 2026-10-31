
extends Control

@onready var play_button: Button = $PlayButton

const TASARIM_BOYUTU := Vector2(1280.0, 720.0)
const BUTON_BOYUTU := Vector2(356.0, 136.0)
const BUTON_KONUMU := Vector2(476.0, 393.0)

func _ready() -> void:
	get_viewport().size_changed.connect(_ekrani_yeniden_olce)
	_ekrani_yeniden_olce()


func _ekrani_yeniden_olce() -> void:
	var ekran_boyutu: Vector2 = size

	var oran_x: float = ekran_boyutu.x / TASARIM_BOYUTU.x
	var oran_y: float = ekran_boyutu.y / TASARIM_BOYUTU.y

	play_button.position = Vector2(
		BUTON_KONUMU.x * oran_x,
		BUTON_KONUMU.y * oran_y
	)

	play_button.size = Vector2(
		BUTON_BOYUTU.x * oran_x,
		BUTON_BOYUTU.y * oran_y
	)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")
