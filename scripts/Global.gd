extends Node

# Oyuncunun seçtiği kategori ve seviye
var secilen_kategori: String = "Animals"
var secilen_seviye: int = 1

# Seviye ve kategori verileri
var kategoriler = {
	"Animals": {
		1: {
			"animals": [
				{"id": "bear", "name": "Bear", "image": "res://assets/animals/bear.png", "target_id": "cave", "scale": 1.0},
				{"id": "buffalo", "name": "Buffalo", "image": "res://assets/animals/buffalo.png", "target_id": "farm", "scale": 1.4},
				{"id": "chick", "name": "Chick", "image": "res://assets/animals/chick.png", "target_id": "brooder", "scale": 1.0}
			],
			"habitats": [
				{"id": "cave", "name": "Cave", "image": "res://assets/homes/Cave.png", "scale": 1.0},
				{"id": "farm", "name": "Farm", "image": "res://assets/homes/Farm.png", "scale": 1.0},
				{"id": "brooder", "name": "Brooder", "image": "res://assets/homes/brooder.png", "scale": 1.0}
			]
		}
	},
	"Farm": {
		1: {
			"animals": [
				{"id": "cow", "name": "Cow", "image": "res://assets/animals/cow.png", "target_id": "pasture", "scale": 1.0},
				{"id": "sheep", "name": "Sheep", "image": "res://assets/animals/sheep.png", "target_id": "pen", "scale": 1.0},
				{"id": "horse", "name": "Horse", "image": "res://assets/animals/horse.png", "target_id": "stable", "scale": 1.0}
			],
			"habitats": [
				{"id": "pasture", "name": "Pasture", "image": "res://assets/homes/pasture.png", "scale": 1.0},
				{"id": "pen", "name": "Pen", "image": "res://assets/homes/pen.png", "scale": 1.0},
				{"id": "stable", "name": "Stable", "image": "res://assets/homes/stable.png", "scale": 1.0}
			]
		}
	},
	"Forest": {
		1: {
			"animals": [
				{"id": "owl", "name": "Owl", "image": "res://assets/animals/owl.png", "target_id": "tree_hollow", "scale": 1.1},
				{"id": "fox", "name": "Fox", "image": "res://assets/animals/fox.png", "target_id": "fox_den", "scale": 1.0},
				{"id": "frog", "name": "Frog", "image": "res://assets/animals/frog.png", "target_id": "pond", "scale": 1.0}
			],
			"habitats": [
				{"id": "tree_hollow", "name": "Tree Hollow", "image": "res://assets/homes/tree_hollow.png", "scale": 1.0},
				{"id": "fox_den", "name": "Fox Den", "image": "res://assets/homes/fox_den.png", "scale": 1.0},
				{"id": "pond", "name": "Pond", "image": "res://assets/homes/pond.png", "scale": 1.0}
			]
		}
	}
}
