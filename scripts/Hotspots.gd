
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
	if background_image.texture == null:
		return

	var gorsel_boyutu = background_image.texture.get_size()

	var oran = min(
		size.x / gorsel_boyutu.x,
		size.y / gorsel_boyutu.y
	)

	var gorunen_boyut = gorsel_boyutu * oran
	var baslangic = (size - gorunen_boyut) / 2.0

	for buton in baslangic_rectleri:
		var eski_rect: Rect2 = baslangic_rectleri[buton]

		buton.position = baslangic + Vector2(
			eski_rect.position.x / TASARIM_BOYUTU.x * gorunen_boyut.x,
			eski_rect.position.y / TASARIM_BOYUTU.y * gorunen_boyut.y
		)

		buton.size = Vector2(
			eski_rect.size.x / TASARIM_BOYUTU.x * gorunen_boyut.x,
			eski_rect.size.y / TASARIM_BOYUTU.y * gorunen_boyut.y
		)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")
	
func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
