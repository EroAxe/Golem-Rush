extends MarginContainer


func setup_screen(time, dmg_taken, dps, alive):
	
	if !alive:
		
		%Time.visible = false
		
	%Time_To_Beat.text = str("%02d:%02d:%06.3f" % [time.hour, time.min, time.sec])
	%Damage_Taken.text = str(dmg_taken)
	%DPS.text = str(dps)
	
	var last_score = ScoreList.add_score(time.sec, dmg_taken, dps)
	
	%Last_Score.text = str(last_score.calculate_total_score() * 100).pad_decimals(0)
	%Highscore.text = str(ScoreList.get_highscore())
	

func _ready():
	
	%Restart.pressed.connect(restart_fight)
	%Menu.pressed.connect(return_to_menu)
	%Scores.pressed.connect(display_scores)
	
	get_tree().paused = true
	

func restart_fight():
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	

func return_to_menu():
	
	get_tree().change_scene_to_file("Menu")
	get_tree().paused = false
	

func display_scores():
	
	pass
	
