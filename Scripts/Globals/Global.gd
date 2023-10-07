extends Node


var camera
var player
var hud

var max_jumps = 1
var jumps = max_jumps
var coins = 0
var power = 0
var eggs = 0
var max_lives = 8
var lives = max_lives

func lose_life():
	camera.shake(0.25,2)
	lives -= 1
	hud.load_health()
	if lives <= 0:
		player.reset_position()
		lives = max_lives
		hud.load_health()

func collect_money(coinType):
	if (coinType == 0):
		coins += 1
	elif (coinType == 1):
		coins += 5
	elif (coinType == 2):
		coins += 10
	elif (coinType == 3):
		coins += 100
	elif (coinType == 4):
		power += 40
	if power >= 80:
		power = 0
	hud.update_power(power)
	hud.load_coins()
