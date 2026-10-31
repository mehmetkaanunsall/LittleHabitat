
extends CanvasLayer

@export var kutlama_sesi: AudioStream

var kutlama_gosterildi := false


func _ready() -> void:
	add_to_group("game_manager")


func oyun_tamamlandi() -> void:
	if kutlama_gosterildi:
		return

	kutlama_gosterildi = true

	if kutlama_sesi != null:
		var oynatici := AudioStreamPlayer.new()
		oynatici.stream = kutlama_sesi
		oynatici.volume_db = -2.0
		add_child(oynatici)
		oynatici.finished.connect(oynatici.queue_free)
		oynatici.play()

	yildizlari_olustur()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://VictoryScreen.tscn")


func yildizlari_olustur() -> void:
	var ekran := get_viewport().get_visible_rect().size

	var renkler: Array[Color] = [
		Color.YELLOW,
		Color.ORANGE,
		Color.DEEP_SKY_BLUE,
		Color.HOT_PINK,
		Color.LIME_GREEN,
		Color.MEDIUM_PURPLE
	]

	for i in range(50):
		var parca := Polygon2D.new()

		var genislik := randf_range(7.0, 13.0)
		var yukseklik := randf_range(9.0, 17.0)

		parca.polygon = PackedVector2Array([
			Vector2(-genislik / 2.0, -yukseklik / 2.0),
			Vector2(genislik / 2.0, -yukseklik / 2.0),
			Vector2(genislik / 2.0, yukseklik / 2.0),
			Vector2(-genislik / 2.0, yukseklik / 2.0)
		])

		parca.color = renkler.pick_random()
		add_child(parca)

		parca.position = Vector2(
			randf_range(0.0, ekran.x),
			randf_range(-ekran.y * 0.5, 0.0)
		)

		var hedef := Vector2(
			parca.position.x + randf_range(-100.0, 100.0),
			ekran.y + randf_range(30.0, 100.0)
		)

		var sure := randf_range(1.5, 2.5)
		var tween := create_tween()

		tween.set_parallel(true)

		tween.tween_property(
			parca,
			"position",
			hedef,
			sure
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

		tween.tween_property(
			parca,
			"rotation",
			randf_range(-8.0, 8.0),
			sure
		)

		tween.tween_property(
			parca,
			"modulate:a",
			0.0,
			sure
		).set_delay(0.5)

		tween.chain().tween_callback(parca.queue_free)
