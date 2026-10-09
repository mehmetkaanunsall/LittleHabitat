extends Area2D

@export var yuva: Area2D
@export var feedback_label: Label
@export var yerlesim_ofseti: Vector2 = Vector2(10, 40)

var surukleniyor := false
var fare_mesafesi := Vector2.ZERO
var baslangic_konumu := Vector2.ZERO
var tamamlandi := false


func _ready():
	baslangic_konumu = global_position
	z_index = 10
	add_to_group("animals")


func _input(event):
	if tamamlandi:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var fare_konumu = get_global_mouse_position()

				if fare_gorselin_uzerinde_mi(fare_konumu):
					surukleniyor = true
					fare_mesafesi = global_position - fare_konumu
			else:
				if surukleniyor:
					surukleniyor = false
					yuva_kontrol()


func _process(_delta):
	if surukleniyor:
		global_position = get_global_mouse_position() + fare_mesafesi


func fare_gorselin_uzerinde_mi(fare_konumu: Vector2) -> bool:
	for child in get_children():
		if child is Sprite2D:
			return child.get_rect().has_point(
				child.to_local(fare_konumu)
			)
	return false


func yuva_kontrol():
	if yuva == null:
		push_warning(name + ": Yuva atanmamis!")
		global_position = baslangic_konumu
		return

	var collision_shape: CollisionShape2D = null

	for child in yuva.get_children():
		if child is CollisionShape2D:
			collision_shape = child
			break

	if collision_shape == null or collision_shape.shape == null:
		push_warning(name + ": Yuvada CollisionShape2D bulunamadi!")
		global_position = baslangic_konumu
		return

	var fare_konumu = get_global_mouse_position()
	var yerel_fare = collision_shape.to_local(fare_konumu)
	var yuvada_mi := false

	if collision_shape.shape is RectangleShape2D:
		var shape = collision_shape.shape as RectangleShape2D
		var rect = Rect2(-shape.size / 2.0, shape.size)
		yuvada_mi = rect.has_point(yerel_fare)

	elif collision_shape.shape is CircleShape2D:
		var shape = collision_shape.shape as CircleShape2D
		yuvada_mi = yerel_fare.length() <= shape.radius

	elif collision_shape.shape is CapsuleShape2D:
		var shape = collision_shape.shape as CapsuleShape2D
		var yari_yukseklik = shape.height / 2.0 - shape.radius
		var en_yakin_y = clampf(
			yerel_fare.y,
			-yari_yukseklik,
			yari_yukseklik
		)
		var en_yakin_nokta = Vector2(0, en_yakin_y)
		yuvada_mi = yerel_fare.distance_to(en_yakin_nokta) <= shape.radius

	else:
		push_warning("Desteklenmeyen yuva CollisionShape2D tipi.")

	if yuvada_mi:
		global_position = yuva.global_position + yerlesim_ofseti
		z_index = 100
		tamamlandi = true

		print(name + ": CORRECT!")

		if tum_hayvanlar_tamamlandi():
			geri_bildirim_goster("🎉", Color.GOLD)
		else:
			geri_bildirim_goster("✓", Color.GREEN)
	else:
		global_position = baslangic_konumu
		geri_bildirim_goster("✖", Color.RED)
		print("YANLIS YUVA! Beklenen yuva: ", yuva.name)


func tum_hayvanlar_tamamlandi() -> bool:
	var hayvanlar = get_tree().get_nodes_in_group("animals")

	if hayvanlar.size() < 3:
		return false

	for hayvan in hayvanlar:
		if not hayvan.tamamlandi:
			return false

	return true


func geri_bildirim_goster(metin: String, renk: Color):
	if feedback_label == null:
		push_warning(name + ": FeedbackLabel atanmamis!")
		return

	feedback_label.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	feedback_label.offset_left = 0
	feedback_label.offset_top = 0
	feedback_label.offset_right = 0
	feedback_label.offset_bottom = 0

	feedback_label.text = metin
	feedback_label.add_theme_color_override("font_color", renk)
	feedback_label.add_theme_font_size_override("font_size", 220)
	feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	feedback_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	feedback_label.z_index = 200
	feedback_label.pivot_offset = feedback_label.size / 2.0
	feedback_label.scale = Vector2(0.2, 0.2)
	feedback_label.modulate = Color(1, 1, 1, 1)
	feedback_label.visible = true

	var tween = create_tween()
	tween.tween_property(
		feedback_label,
		"scale",
		Vector2(1.0, 1.0),
		0.3
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	await tween.finished
	await get_tree().create_timer(0.8).timeout

	if not is_instance_valid(feedback_label):
		return

	if feedback_label.text != metin:
		return

	var fade = create_tween()
	fade.tween_property(
		feedback_label,
		"modulate:a",
		0.0,
		0.25
	)
	await fade.finished

	if is_instance_valid(feedback_label) and feedback_label.text == metin:
		feedback_label.visible = false
		feedback_label.modulate = Color(1, 1, 1, 1)
		feedback_label.scale = Vector2(1.0, 1.0)
