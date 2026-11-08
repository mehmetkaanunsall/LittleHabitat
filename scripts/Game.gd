
extends Node2D

@onready var arka_plan: Sprite2D = $GameBackgroundSprite
@onready var oyun_alani: Node2D = $OyunAlani

const TASARIM_BOYUTU := Vector2(1280.0, 720.0)

func _ready() -> void:
	get_viewport().size_changed.connect(ekrani_ayarla)
	ekrani_ayarla()


func ekrani_ayarla() -> void:
	if arka_plan.texture == null:
		return

	var ekran_boyutu := get_viewport_rect().size

	var olcek_x := ekran_boyutu.x / TASARIM_BOYUTU.x
	var olcek_y := ekran_boyutu.y / TASARIM_BOYUTU.y

	# Arka plan
	var olcek := maxf(olcek_x, olcek_y)
	var gorsel_boyutu := arka_plan.texture.get_size()

	arka_plan.scale = Vector2(
		olcek * TASARIM_BOYUTU.x / gorsel_boyutu.x,
		olcek * TASARIM_BOYUTU.y / gorsel_boyutu.y
	)

	arka_plan.position = ekran_boyutu / 2.0

	# Hayvanlar ve yuvalar
	oyun_alani.scale = Vector2(olcek_x, olcek_y)
	oyun_alani.position = Vector2(45.0, 0.0)
