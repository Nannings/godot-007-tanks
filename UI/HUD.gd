extends CanvasLayer

var bar_red = preload("res://assets/UI/barHorizontal_red_mid 200.png")
var bar_green = preload("res://assets/UI/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://assets/UI/barHorizontal_yellow_mid 200.png")
var bar_texture

func _ready():
	$Margin/Container/HealthBar.value = 100
#	print(get_node('/root/Map01/Player'))
#	print(get_node('..//Player'))
	get_node('..//Player').connect('health_changed', self, 'update_healthbar')
	get_node('..//Player').connect('ammo_changed', self, 'update_ammo')
	
func update_ammo(value):
	$Margin/Container/AmmoGauge.value = value

func update_healthbar(value):
	bar_texture = bar_green
	if value < 60:
		bar_texture = bar_yellow
	if value < 25:
		bar_texture = bar_red
	$Margin/Container/HealthBar.texture_progress = bar_texture
	$Margin/Container/HealthBar/Tween.interpolate_property($Margin/Container/HealthBar,
	'value', $Margin/Container/HealthBar.value, 
	value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Margin/Container/HealthBar/Tween.start()
	$AnimationPlayer.play('healthbar_flash')

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'healthbar_flash':
		$Margin/Container/HealthBar.texture_progress = bar_texture