extends Control

var host

onready var songs = $"%MusicAudioPlayer".get_children()

var basic_player_data = {
	"chosen_song": 0,
	"muted": false
}
var music_player_data
var play_music = false
var current_song = null
var volumes = {
	"Losing": -22,
	"Neutral": -14,
	"Winning" : -10,
}

#	--------------------------------------------------------------------------------------------- |
func get_music_player_data():
	var match_data = Global.current_game.match_data
	var data_name = "music_player_data_" + str(host.fighter.id)
	
	if match_data.has(data_name):
		music_player_data = match_data[data_name]
		
	else:
		match_data[data_name] = basic_player_data
		match_data[data_name]
		music_player_data = match_data[data_name]
	
	return music_player_data

#	--
func _on_Tray_toggled(button_pressed):
	if button_pressed == true:
		$"%Tray".icon = preload("res://_NokBetrayer/characters/betrayer/ui/musicplayer/musicplayer-traySHOW.png")
		$"%MusicVBoxContainer".visible = true
	
	else:
		$"%Tray".icon = preload("res://_NokBetrayer/characters/betrayer/ui/musicplayer/musicplayer-trayHIDE.png")
		$"%MusicVBoxContainer".visible = false
		
func _on_Mute_toggled(button_pressed):
	if button_pressed == true:
		music_player_data.muted = true
		
	else:
		music_player_data.muted = false
		
func _on_Previous_pressed():
	music_player_data.chosen_song -= 1
	if music_player_data.chosen_song < 0:
		music_player_data.chosen_song = len(songs) - 1
	
	song_changed()

func _on_Next_pressed():
	music_player_data.chosen_song += 1
	if music_player_data.chosen_song > len(songs) - 1:
		music_player_data.chosen_song = 0
	
	song_changed()
		
#	--
func song_changed():
	$"%MusicAudioPlayer".playing = false
		
func match_song_with_position(song):
	var id = 0
	
	for found_songs in songs:
		if songs[id].song == song:
			return id
		
		id += 1
		
#	--------------------------------------------------------------------------------------------- |
func _ready():
	host = self.owner
	
	#	--
	$"%Tray".pressed = false
	
	#	--	MUSIC PLAYER DATA
	if host.fighter:
		var match_data = Global.current_game.match_data
		var data_name = "music_player_data" + str(host.fighter.id)
		
		if host.fighter.get_node("%Stuff").skin == "Munanyou":
			songs = $"%SongsM".get_children()
		else:
			songs = $"%Songs".get_children()
		
		get_music_player_data()
		$"%Mute".pressed = music_player_data.muted == true

func _process(delta):
	if host.fighter:
		
		#	--	ALIGNMENT
		if host.player_id == 1:
			$"%TrayButtonContainer".alignment = BoxContainer.ALIGN_BEGIN
			$"%MusicPlayerContainer".alignment = BoxContainer.ALIGN_BEGIN
			$"%SongNameContainer".alignment = BoxContainer.ALIGN_BEGIN
			$"%Title".align = Label.ALIGN_LEFT
			
			if host.under_healthbar == true:
				$"%MusicPlayer".rect_position = Vector2(-50, 90)
			
			else:
				$"%MusicPlayer".rect_position = Vector2(10, -60)
			
		elif host.player_id == 2:
			$"%TrayButtonContainer".alignment = BoxContainer.ALIGN_END
			$"%MusicPlayerContainer".alignment = BoxContainer.ALIGN_END
			$"%SongNameContainer".alignment = BoxContainer.ALIGN_END
			$"%Title".align = Label.ALIGN_RIGHT
			#
			if host.under_healthbar == true:
				$"%MusicPlayer".rect_position = Vector2(-190, 90)
			
			else:
				$"%MusicPlayer".rect_position = Vector2(-200, -60)
				
		#	--	CONDITIONS
		$"%MusicPlayer".visible = host.fighter.get_node("%Stuff").music_access == true
		play_music = host.fighter.abs_asc > 0 and host.fighter.game_over != true
		play_music = play_music and $"%MusicPlayer".visible
		
		#	--	MUSIC PLAYING
		if music_player_data.muted == true:
			play_music = false
			$"%MusicAudioPlayer".playing = false
		
		if play_music == true:
			if $"%MusicAudioPlayer".playing == false:
				$"%MusicAudioPlayer".stream = songs[music_player_data.chosen_song].song
				$"%MusicAudioPlayer".playing = true
				
			#	--	MUSIC VOLUME CONTROL
			if host.fighter.opponent.combo_count >= 1:
				$"%MusicAudioPlayer".volume_db = lerp($"%MusicAudioPlayer".volume_db, volumes.Losing, 1)
			
			elif host.fighter.combo_count >= 1:
				$"%MusicAudioPlayer".volume_db = lerp($"%MusicAudioPlayer".volume_db, volumes.Winning, 1)
			
			else:
				$"%MusicAudioPlayer".volume_db = lerp($"%MusicAudioPlayer".volume_db, volumes.Neutral, 1)
			
		else:
			$"%MusicAudioPlayer".volume_db = lerp($"%MusicAudioPlayer".volume_db, -80, 1)
			
		
		#	--	DISPLAY
		$"%SongName".text = songs[music_player_data.chosen_song].song_name
			
		if music_player_data.muted == true:
			$"%Mute".icon = load("res://_NokBetrayer/characters/betrayer/ui/musicplayer/musicplayer-musicOFF.png")
		else:
			$"%Mute".icon = load("res://_NokBetrayer/characters/betrayer/ui/musicplayer/musicplayer-musicON.png")
