extends Node2D

@export var game_ui: CanvasLayer
@export var game_over_ui_template: PackedScene

@export var main_music: AudioStream
@export var game_over_music: AudioStream
@onready var music_player: AudioStreamPlayer = $MusicPlayer

var current_music_index: int = 0


func _ready():
	GameManager.game_over.connect(trigger_game_over)
	music_player.stream = main_music
	music_player.play()

	# Conecta o sinal "finished" para reiniciar a música
	music_player.connect("finished", Callable(self, "_on_music_finished"))

func _on_music_finished():
	# Reinicia a música quando terminar
	music_player.play()
	
func trigger_game_over():
	# Deletar GameUI
	if game_ui:
		game_ui.queue_free()
		game_ui = null

	# Criar GameOverUI
	var game_over_ui: GameOver = game_over_ui_template.instantiate()
	add_child(game_over_ui)
	
	# Parar a música principal
	if music_player.playing:
		music_player.stop()
	
	# Tocar a música de Game Over
	if game_over_music:
		music_player.stream = game_over_music
		music_player.play()
		
func restart_main_music():
	if main_music:
		music_player.stream = main_music
		music_player.play()
