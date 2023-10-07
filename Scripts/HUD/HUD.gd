extends CanvasLayer


func _ready():
	load_coins()
	load_health()
	load_eggs()
	set_custom_viewport($"../../../Viewport")
	Global.hud = self


func load_health():
	$Health/HealthFull.rect_size.x = (Global.lives/2 * 9)
	if Global.lives % 2 == 0:
		$Health/HealthHalf.rect_size.x = 0
	if Global.lives % 2 == 1:
		$Health/HealthHalf.rect_size.x = 9
		
	$Health/HealthEmpty.rect_size.x = ((Global.max_lives - Global.lives)/2 * 9)
		
	$Health/HealthHalf.rect_position.x = $Health/HealthFull.rect_position.x + $Health/HealthFull.rect_size.x * $Health/HealthFull.rect_scale.x
	$Health/HealthEmpty.rect_position.x = $Health/HealthHalf.rect_position.x + $Health/HealthHalf.rect_size.x * $Health/HealthHalf.rect_scale.x

	
func load_coins():
	if Global.coins >= 1000:
		$Money/Amount.text = String(Global.coins)
	elif Global.coins >= 100:
		$Money/Amount.text = "0" + String(Global.coins)
	elif Global.coins >= 10:
		$Money/Amount.text = "00" + String(Global.coins)
	else:
		$Money/Amount.text = "000" + String(Global.coins)
	$Money/Amount.text = $Money/Amount.text.substr(0,2) + "." + $Money/Amount.text.substr(2,2)
	
func load_eggs():
	$Eggs/Amount.text = String(Global.eggs)
	
func update_power(power):
	$PowerProgress.set_value(power)
