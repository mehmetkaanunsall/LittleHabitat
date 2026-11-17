
extends Control

@onready var background_image: TextureRect = $"../BackgroundImage"

const TASARIM_BOYUTU := Vector2(1280.0, 720.0)

var baslangic_rectleri: Dictionary = {}


func _ready() -> void:
	for buton in get_children():
		if buton is Button:
			baslangic_rectleri[buton] = Rect2(
				buton.position,
				buton.size
			)
			
		if buton.name == "HomeHotspot":
			buton.pressed.connect(_on_home_pressed)
		else:
			buton.pressed.connect(_on_play_pressed)
		buton.mouse_filter = Control.MOUSE_FILTER_STOP

	get_viewport().size_changed.connect(_yerlesimi_guncelle)
	call_deferred("_yerlesimi_guncelle")


func _yerlesimi_guncelle() -> void:
	var oran_x = size.x / TASARIM_BOYUTU.x
	var oran_y = size.y / TASARIM_BOYUTU.y

	for buton in baslangic_rectleri:
		var eski_rect: Rect2 = baslangic_rectleri[buton]

		buton.position = Vector2(
			eski_rect.position.x * oran_x,
			eski_rect.position.y * oran_y
		)

		buton.size = Vector2(
			eski_rect.size.x * oran_x,
			eski_rect.size.y * oran_y
		)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")
	
func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
