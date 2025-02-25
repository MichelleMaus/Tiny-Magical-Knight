class_name MobSpawn
extends Node2D

@export var creatures: Array[PackedScene]
var mobs_per_minute: float = 60.0

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
var cooldown: float = 0.0

func _process(delta: float):
	# Ignorar GameOver:
	if GameManager.is_game_over: return
	
	# Frequencia: monstros por minuto
	# Temporizador (cooldown)
	cooldown -= delta
	if cooldown > 0: return
	# código continua se o cooldown estiver zerado, deve definir um novo cooldown
	var interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	# Checar se o ponto é válido
	# Perguntar pro jogo se o ponto tem colisão
	var point = get_point()
	var world_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	parameters.collision_mask = 0b1001
	var result: Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty(): return
	
	# Instanciar uma criatura aleatória
		# Pegar criatura aleatória
		# Pegar ponto aleatório
		# Instanciar cena
		# Colocar na posição certa
		# Definir o parent
	var index = randi_range(0, creatures.size() -1)
	var creature_scene = creatures[index]
	# var point = get_point() 
	var creature = creature_scene.instantiate()
	creature.global_position = point
	get_parent().add_child(creature) #para criar dentro de TestMobSpawning
	pass
	
func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf() # Random Float
	return path_follow_2d.global_position
	
