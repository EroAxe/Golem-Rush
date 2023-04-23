extends PanelContainer

@export_file var fight_level

func _ready():
	
	%Fight.pressed.connect(start_fight)
	%Credits.pressed.connect(display_credits)
	%Quit.pressed.connect(quit)
	

func start_fight():
	
	get_tree().change_scene_to_file(fight_level)
	

func display_credits():
	
	%Credits_Panel.visible = true
	

func quit():
	
	get_tree().quit()
	
