extends Control

const GAME_SCENE = "res://Game.tscn"
const MAIN_MENU_SCENE = "res://MainMenu.tscn"
const LEVEL_MENU_SCENE = "res://LevelMenu.tscn"

func _ready() -> void:
	$Hotspots/AnimalsButton.pressed.connect(_on_animals_pressed)
	$Hotspots/FarmButton.pressed.connect(_on_farm_pressed)
	$Hotspots/ForestButton.pressed.connect(_on_forest_pressed)
	$Hotspots/OceanButton.pressed.connect(_on_ocean_pressed)
	$MainContainer/LevelGrid/LevelCard1/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard2/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard3/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard4/CardContent/PlayButton.pressed.connect(_on_play_pressed)




func _on_play_pressed() -> void:
	print("PLAY BUTONUNA TIKLANDI!")
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_home_pressed() -> void:
	print("HOME TIKLANDI")
	print("SAHNE YOLU: ", MAIN_MENU_SCENE)

	var hata = get_tree().change_scene_to_file(MAIN_MENU_SCENE)
	print("SONUC: ", hata)
	
func _on_animals_pressed() -> void:
	_open_level_menu("Animals")


func _on_farm_pressed() -> void:
	_open_level_menu("Farm")


func _on_forest_pressed() -> void:
	_open_level_menu("Forest")


func _on_ocean_pressed() -> void:
	_open_level_menu("Ocean")


func _open_level_menu(category: String) -> void:
	LevelMenu.selected_category = category
	Global.secilen_kategori = category # ---> BU SATIRI YENİ EKLEDİK
	
	var scene_tree := Engine.get_main_loop() as SceneTree
	scene_tree.change_scene_to_file(LEVEL_MENU_SCENE)
