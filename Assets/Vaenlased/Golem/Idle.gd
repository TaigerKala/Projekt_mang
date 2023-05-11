extends State

func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	
func update(delta: float) -> void:
	if owner.target:
		state_machine.transition_to("move")
