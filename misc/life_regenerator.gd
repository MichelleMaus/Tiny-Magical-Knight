extends Node2D

@export var regeneration_amount: int = 10
@export var heal_sound: AudioStream

#Detectar colisão com o jogador
func _ready():
	$Area2D.body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(regeneration_amount, heal_sound)
		player.meat_collected.emit(regeneration_amount)
		queue_free()
