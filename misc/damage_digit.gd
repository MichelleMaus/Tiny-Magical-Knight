extends Node2D

@export var value: int = 0

func _ready():
	# Transformar de número inteiro para texto
	%Label.text = str(value)
