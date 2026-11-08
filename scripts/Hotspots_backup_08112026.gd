
extends Control

@onready var background_image: TextureRect = $"../BackgroundImage"

@onready var animals_button: Button = $AnimalsButton
@onready var farm_button: Button = $FarmButton
@onready var forest_button: Button = $ForestButton
@onready var ocean_button: Button = $OceanButton

# Görsel üzerindeki PLAY alanlarının oransal konumları
const PLAY_ALANLARI = {
	"AnimalsButton": Rect2(0.258, 0.414, 0.146, 0.058),
	"FarmButton": Rect2(0.598, 0.414, 0.145, 0.058),
	"ForestButton": Rect2(0.258, 0.818, 0.146, 0.058),
	"OceanButton": Rect2(0.598, 0.818, 0.145, 0.058)
}

func _ready() -> void:
	var butonlar = [
		animals_button,
		farm_button,
		forest_button,
		ocean_button
	]

	for buton in butonlar:
		buton.text = "TEST"
		buton.focus_mode = Control.FOCUS_NONE

		#buton.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		#buton.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		#buton.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
		#buton.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

		buton.pressed.connect(
			Callable(get_parent(), "_on_play_pressed")
		)
		print(buton.name, " sinyali bağlandı.")

	get_viewport().size_changed.connect(_yerlesimi_guncelle)
	resized.connect(_yerlesimi_guncelle)

	call_deferred("_yerlesimi_guncelle")


func _yerlesimi_guncelle() -> void:
	print("GÖRSEL BOYUTU: ", background_image.size)
	var alan = background_image.size

	if alan.x <= 0 or alan.y <= 0:
		return

	for buton_adi in PLAY_ALANLARI:
		var buton = get_node(buton_adi)
		var rect = PLAY_ALANLARI[buton_adi]

		buton.position = Vector2(
			rect.position.x * alan.x,
			rect.position.y * alan.y
		)

		buton.size = Vector2(
			rect.size.x * alan.x,
			rect.size.y * alan.y
		)
		print(buton_adi, " | Konum: ", buton.position, " | Boyut: ", buton.size)
