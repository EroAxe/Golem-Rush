extends PanelContainer

var cur_time := 0.0

func _ready():
	
	%Cur_Time.text = str(cur_time).pad_decimals(3)
	

func _physics_process(delta):
	
	cur_time += delta
	var time = get_time()
	
	%Cur_Time.text = str("%02d:%02d:%06.3f" % [time.hour, time.min, time.sec])
	

func get_time():
	
	var time : Dictionary = {"sec" : 0.0, "min" : 0, "hour" : 0}
	
	time.sec = cur_time 
	
	if time.sec >= 60:
		time.min = time.sec / 60
		time.sec -= floor(time.min) * 60
	
	if time.min >= 60:
		time.hour = time.min / 60
		time.min -= floor(time.hour) * 60
	
	return time
	
