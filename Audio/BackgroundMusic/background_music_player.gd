extends AudioStreamPlayer

@onready var menu_music: AudioStream = preload("res://Audio/BackgroundMusic/MenuMusic.mp3")
@onready var gameplay_music1: AudioStream = preload("res://Audio/BackgroundMusic/GameplayMusic1.mp3")
@onready var gameplay_music2: AudioStream = preload("res://Audio/BackgroundMusic/GameplayMusic2.mp3")
@onready var gameplay_music3: AudioStream = preload("res://Audio/BackgroundMusic/GameplayMusic3.mp3")
@onready var gameplay_songs = [gameplay_music1, gameplay_music2, gameplay_music3]
var current_gameplay_song = 0


func play_menu_music():
	if stream != menu_music:
		stream = menu_music
		play()


func play_gameplay_music():
	stream = gameplay_songs[current_gameplay_song]
	play()

func _on_finished():
	current_gameplay_song = (current_gameplay_song+1)%3
	play_gameplay_music()
