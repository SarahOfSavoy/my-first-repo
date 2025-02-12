extends Area2D
class_name Bullet

var direction

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += direction * delta * 250.0

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body is Mob:
		body.queue_free()
