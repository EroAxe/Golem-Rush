extends Node

var scores : Array[Score]
@onready var cur_score := Score.new()

var highscore : Score

func _ready():
	
	load_scores()
	

func get_highscore():
	
	if !highscore:
		
		return 0
		
	
	return highscore
	

func load_scores():
	
	var save = ResourceLoader.load("user://Scores.res")
	
	if !save:
		
		return
	
	scores = save.scores
	
	highscore = find_highest_score(scores)
	

func add_score(time, dmg_taken, dps):
	
	var new = Score.new()
	scores.append(new)
	
	new.time_to_beat = time
	new.damage_taken = dmg_taken
	new.dps = dps
	
	if highscore and new.calculate_total_score() > highscore.calculate_total_score():
		
		highscore = new
		
	
	return new
	

func find_highest_score(scores):
	
	var highest : Score
	var val := 0.0
	for all in scores:
		
		all = all as Score
		var total = all.calculate_total_score()
		if total > val:
			
			val = total
			highest = all
			
		
	
	return highest
	

func _notification(what):
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		
		var save = Score_Save.new()
		save.save_scores(scores)
		
	
