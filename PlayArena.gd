extends Node2D

onready var skoor := $Tegelane/Camera2D/SkooriLabel
onready var player_hitbox := $Tegelane/AtkHitbox
onready var spawn1 := $Position1
onready var spawn2 := $Position2
onready var spawn_timer := $SpawnTimer

var skoori_number := 0

const vaenlane_scene := preload("res://Assets/Vaenlased/Golem/Golem.tscn")

func _ready() -> void:
	player_hitbox.connect("hit_enemy", self, "_update_skoor")
	spawn_timer.connect("timeout", self, "_spawn_enemy")
	
func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _update_skoor() -> void:
	skoor.text = "Skoor: " + str(skoori_number)
	skoori_number += 1

func _spawn_enemy() -> void:
	var vaenlane = vaenlane_scene.instance()
	add_child(vaenlane)
