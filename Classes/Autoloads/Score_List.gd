extends Node

var scores : Array[Score]
@onready var cur_score := Score.new()

func _ready():
	
	load_scores()
	

func load_scores():
	
	var save = ResourceLoader.load("user://Scores.res")
	
	if !save:
		
		return
	
	scores = save.scores
	

func _notification(what):
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		
		var save = Score_Save.new()
		save.save_scores(scores)
		
	
