extends Node

@onready var music_audio_stream_player: AudioStreamPlayer = %MusicAudioStreamPlayer

var intensity := 0.0


func _process(delta: float) -> void:
	var interactive_stream: AudioStreamInteractive = music_audio_stream_player.stream

	if not interactive_stream:
		return

	for a in 2:
		var clip: AudioStreamSynchronized = interactive_stream.get_clip_stream(a)

		for n in clip.stream_count:
			var amount := 6.0 * intensity + 1.0
			var volume := clampf(amount - n, 0, 1)
			clip.set_sync_stream_volume(n, linear_to_db(volume))
			if n == 5 and volume > 0:
				clip.set_sync_stream_volume(2, linear_to_db(1.0 - volume))


func play_music() -> void:
	music_audio_stream_player.play()


func game_over() -> void:
	music_audio_stream_player.get_stream_playback().switch_to_clip_by_name(&"over")


func _on_h_slider_value_changed(value: float) -> void:
	intensity = value / 6.0
