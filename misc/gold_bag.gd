extends Sprite2D

@export var gold_coins_amount: int = 5

func _ready():
	$Area2D.body_entered.connect(on_gold_entered)
	
func on_gold_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player: Player = body
		player.gold_bag_coins(gold_coins_amount)
		player.gold_collected.emit(gold_coins_amount)
		queue_free()
