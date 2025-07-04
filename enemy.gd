extends Node2D

# Velocidad de movimiento
var velocidad = 100
# Dirección actual (1 = derecha, -1 = izquierda)
var direccion = 1

# Límites izquierdo y derecho del movimiento
var limite_izq = 100
var limite_der = 300

func _process(delta):
	# Mover horizontalmente
	position.x += direccion * velocidad * delta

	# Cambiar dirección al llegar a un borde
	if position.x < limite_izq:
		direccion = 1
		$AnimatedSprite2D.flip_h = false  # Dar vuelta el sprite si lo necesitás

	elif position.x > limite_der:
		direccion = -1
		$AnimatedSprite2D.flip_h = true


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
