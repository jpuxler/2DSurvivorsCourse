extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
var current_healt: float

func _ready():
	current_healt = max_health

func damage(damage_amount: float):
	current_healt = max(current_healt - damage_amount, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()
	
	
func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_healt / max_health, 1)


func check_death():
	if current_healt == 0:
		died.emit()
		owner.queue_free()
