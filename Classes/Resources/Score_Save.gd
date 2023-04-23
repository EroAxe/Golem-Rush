extends Resource
class_name Score_Save

@export var scores : Array[Score]


func save_scores(cur_scores):
	
	scores = cur_scores
	ResourceSaver.save(self, "user://Scores.res")
	
