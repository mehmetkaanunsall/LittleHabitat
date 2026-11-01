extends Node2D

@onready var arka_plan: Sprite2D = $GameBackgroundSprite

const TASARIM_BOYUTU := Vector2(1280.0, 720.0)

func _ready() -> void:
	get_viewport().size_changed.connect(arka_plani_ayarla)
	arka_plani_ayarla()


func arka_plani_ayarla() -> void:
	if arka_plan.texture == null:
		return

	var ekran_boyutu := get_viewport_rect().size
	var gorsel_boyutu := arka_plan.texture.get_size()

	var olcek_x := ekran_boyutu.x / gorsel_boyutu.x
	var olcek_y := ekran_boyutu.y / gorsel_boyutu.y

	var olcek := maxf(olcek_x, olcek_y)

	arka_plan.scale = Vector2(olcek, olcek)
	arka_plan.position = ekran_boyutu / 2.0
