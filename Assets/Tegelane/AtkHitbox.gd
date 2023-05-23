extends Area2D

signal hit_enemy

func _ready() -> void:
	var area = get_node(".")
	area.connect("body_entered", self, "_on_atk_body_entered")

func _on_atk_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var enemy: Enemy = body as Enemy
		enemy.take_dmg(10)
		emit_signal("hit_enemy")
