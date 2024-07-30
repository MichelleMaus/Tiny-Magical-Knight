extends Node


@export var speed: float = 1

#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var enemy: Enemies
var sprite: AnimatedSprite2D

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")
	enemy.health
	pass

func _physics_process(delta: float):
	# Ignorar GameOver:
	if GameManager.is_game_over: return
	
	# Calcular direção
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position 
	var input_vector = difference.normalized()
	
	# Movimento
	enemy.velocity = input_vector * speed * 100.0 
	#input_vector = vector2 que varia entre -1 e 1 em ambos os eixos
	enemy.move_and_slide()

	# Girar Sprite
	if input_vector.x > 0:
		sprite.flip_h = false
		# Desmarcar flipH do Sprite2D
	elif input_vector.x < 0:
		# Marcar FlipH do Sprite2D
		sprite.flip_h = true
