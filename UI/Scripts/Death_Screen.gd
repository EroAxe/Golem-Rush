extends MarginContainer


func setup_screen(time, dmg_taken, avg_dps):
	
	%Time_To_Beat.text = str("%02d:%02d:%06.3f" % [time.hour, time.min, time.sec])
	%Damage_Taken.text = str(dmg_taken)
	%Average_DPS.text = str(avg_dps)
	

func _ready():
	
	%Restart.pressed.connect(restart_fight)
	%Menu.pressed.connect(return_to_menu)
	%Scores.pressed.connect(display_scores)
	
	get_tree().paused = true
	

func restart_fight():
	
	get_tree().reload_current_scene()
	

func return_to_menu():
	
	get_tree().change_scene_to_file("Menu")
	

func display_scores():
	
	pass
	
