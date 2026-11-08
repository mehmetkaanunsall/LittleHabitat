extends Control

const GAME_SCENE = "res://Game.tscn"
const MAIN_MENU_SCENE = "res://MainMenu.tscn"

func _ready() -> void:
	$MainContainer/LevelGrid/LevelCard1/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard2/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard3/CardContent/PlayButton.pressed.connect(_on_play_pressed)
	$MainContainer/LevelGrid/LevelCard4/CardContent/PlayButton.pressed.connect(_on_play_pressed)

	
	$HomeButton.show()
	$HomeButton.z_index = 100
	$HomeButton.modulate = Color.WHITE
	$HomeButton.gui_input.connect(func(event):
		print("AAAAAAA")
		if event is InputEventMouseButton and event.pressed:
			print("HOME ALANINA TIKLANDI")
	)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_home_pressed() -> void:
	print("HOME TIKLANDI")
	print("SAHNE YOLU: ", MAIN_MENU_SCENE)

	var hata = get_tree().change_scene_to_file(MAIN_MENU_SCENE)
	print("SONUC: ", hata)
