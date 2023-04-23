extends Resource
class_name Score_Save

@export var scores : Array[Score]
@export var highest_score : Score
@export var recent_score : Score


func save_scores(cur_scores):
	
	scores = cur_scores
	recent_score = scores[-1]
	highest_score = ScoreList.find_highest_score(cur_scores)
	ResourceSaver.save(self, "user://Scores.res")
	

