extends Camera2D

var shake_amount = 0
var default_offset = offset
var shake_over = true
onready var timer = $Timer
onready var tween = $Tween

func _ready():
	set_process(false)
	Global.camera = self
	randomize()
	
func _physics_process(delta):
	
	if !shake_over:
		offset = Vector2(rand_range(-1,1) * shake_amount, rand_range(-1,1) * shake_amount)
	


func shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()
	shake_over = false
	


func _on_Timer_timeout():
	set_process(false)
	tween.interpolate_property(self, "offset", offset, default_offset, 0.1, 6, 2)
	tween.start()
	shake_over = true
