extends ProgressBar

func _on_health_health_changed(health: HealthComponent) -> void:
	max_value = health.max_health
	value = health.health
