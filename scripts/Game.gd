extends Node2D

@onready var arka_plan: Sprite2D = $GameBackgroundSprite
@onready var oyun_alani: Node2D = $OyunAlani

# Sahnedeki mevcut hayvan ve yuva düğümlerini referans alıyoruz
@onready var hayvan_1 = $OyunAlani/Bear
@onready var hayvan_2 = $OyunAlani/Buffalo
@onready var hayvan_3 = $OyunAlani/Chick

@onready var yuva_1 = $OyunAlani/Cave
@onready var yuva_2 = $OyunAlani/Farm
@onready var yuva_3 = $OyunAlani/Brooder

const TASARIM_BOYUTU := Vector2(1280.0, 720.0)

func _ready() -> void:
	_arka_plani_yukle() 
	_seviye_verilerini_yukle()
	
	get_viewport().size_changed.connect(ekrani_ayarla)
	ekrani_ayarla()

func _arka_plani_yukle() -> void:
	var dosya_yolu = ""
	match Global.secilen_kategori:
		"Animals":
			dosya_yolu = "res://arkaplan_animals.png"
		"Farm":
			dosya_yolu = "res://arkaplan_farm.png"
		"Forest":
			dosya_yolu = "res://images/arkaplan_forest.png"
		"Ocean":
			dosya_yolu = "res://arkaplan_ocean.png"
			
	if dosya_yolu != "":
		arka_plan.texture = load(dosya_yolu)

func _seviye_verilerini_yukle() -> void:
	var seviye_verisi = Global.kategoriler[Global.secilen_kategori][Global.secilen_seviye]
	var hayvan_dugumleri = [hayvan_1, hayvan_2, hayvan_3]
	var yuva_dugumleri = [yuva_1, yuva_2, yuva_3]
	
	# 1280x720 tasarım ekranına göre üst, orta ve alt noktalar:
	var yuva_y_konumlari = [125.0, 360.0, 595.0] 
	
	# 2. YUVALARI GÜNCELLE, BOYUTLANDIR VE KONUMLANDIR
	for i in range(3):
		var veri = seviye_verisi["habitats"][i]
		yuva_dugumleri[i].name = veri["id"] 
		
		var yeni_texture = load(veri["image"])
		if yeni_texture:
			yuva_dugumleri[i].texture = yeni_texture
			
			# Taban boyutu 270.0 ile tüm levellerde yuvalar arası ferah boşluk kalır
			var gorsel_boyutu = yeni_texture.get_size()
			var ozel_olcek = veri.get("scale", 1.0)
			var oran = (270.0 * ozel_olcek) / maxf(gorsel_boyutu.x, gorsel_boyutu.y) 
			yuva_dugumleri[i].scale = Vector2(oran, oran)
			
			# X konumu editördeki orijinal yerinde sabit kalır (tüm levellerle aynı mesafe)
			yuva_dugumleri[i].position.y = yuva_y_konumlari[i]

	# 3. HAYVANLARI GÜNCELLE VE BOYUTLANDIR
	for i in range(3):
		var veri = seviye_verisi["animals"][i]
		hayvan_dugumleri[i].name = veri["id"] 
		
		for y in yuva_dugumleri:
			if y.name == veri["target_id"]:
				hayvan_dugumleri[i].yuva = y.get_node("HomeArea") 
				break
				
		for child in hayvan_dugumleri[i].get_children():
			if child is Sprite2D:
				var yeni_texture = load(veri["image"])
				if yeni_texture:
					child.texture = yeni_texture
					
					var gorsel_boyutu = yeni_texture.get_size()
					var ozel_olcek = veri.get("scale", 1.0)
					var oran = (180.0 * ozel_olcek) / maxf(gorsel_boyutu.x, gorsel_boyutu.y) 
					child.scale = Vector2(oran, oran)
				break

func ekrani_ayarla() -> void:
	if arka_plan.texture == null:
		return

	var ekran_boyutu := get_viewport_rect().size

	var olcek_x := ekran_boyutu.x / TASARIM_BOYUTU.x
	var olcek_y := ekran_boyutu.y / TASARIM_BOYUTU.y

	var olcek := maxf(olcek_x, olcek_y)
	var gorsel_boyutu := arka_plan.texture.get_size()

	arka_plan.scale = Vector2(
		olcek * TASARIM_BOYUTU.x / gorsel_boyutu.x,
		olcek * TASARIM_BOYUTU.y / gorsel_boyutu.y
	)

	arka_plan.position = ekran_boyutu / 2.0

	oyun_alani.scale = Vector2(olcek_x, olcek_y)
	oyun_alani.position = Vector2(45.0, 0.0)
