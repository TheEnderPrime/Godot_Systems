extends Node

signal on_health_amount_max_changed
signal on_damaged
signal on_healed
signal on_died

@export var healthAmountMax: int
@export var healthAmount: int

@onready var DOT_Timer = $DOT_Timer

var DOTDamage := 0
var DOTDuration := 0

var isInvincible := false

# Testing Function
func _input(event):
	if event.is_action_pressed("heal"):
		heal(1)
	if event.is_action_pressed("damage"):
		damage(1)
	if event.is_action_pressed("healFull"):
		healFull()
	if event.is_action_pressed("setHealthAmountMax"):
		setHealthAmountMax(healthAmountMax*1.5, true)
	if event.is_action_pressed("damageOverTime"):
		damageOverTime(2, 5)
	print(str(healthAmount) + " / " + str(healthAmountMax))

# instantiates health to max
func _ready():
	healthAmount = healthAmountMax

func damage(damageAmount: int) -> void:
	if isInvincible: return
	healthAmount -= damageAmount
	healthAmount = clamp(healthAmount, 0, healthAmountMax)
	print("Damage Dealt: " + str(damageAmount))
	on_damaged.emit()
	if isDead(): 
		print("DEAD")
		on_died.emit()

func damage_over_time(damageAmount: int, duration: int):
	DOTDamage = damageAmount
	DOTDuration = duration
	$DOT_Timer.start()
	pass

func heal(healAmount: int) -> void:
	healthAmount += healAmount
	healthAmount = clamp(healthAmount, 0, healthAmountMax)
	print("Health Healed: " + str(healAmount))
	on_healed.emit()

func heal_full() -> void:
	healthAmount = healthAmountMax
	print("Healed Full to: " + str(healthAmountMax))
	
func is_dead() -> bool:
	return healthAmount == 0
	
func is_health_full() -> bool:
	return healthAmount == healthAmountMax

func get_health_amount() -> int:
		return healthAmount

func get_health_amount_max() -> int:
		return healthAmountMax
		
func get_health_amount_normalized() -> float:
	return (healthAmount/healthAmountMax) as float

func set_invincible(v: bool) -> void:
	isInvincible = v

func set_health_amount_max(newHealthAmountMax: int, updateHealthAmount: bool) -> void:
	healthAmountMax = newHealthAmountMax
	
	if(updateHealthAmount):
		healthAmount = healthAmountMax
		on_health_amount_max_changed.emit()

func _on_dot_timer_timeout() -> void:
	damage(DOTDamage)
	DOTDuration -= 1
	print(DOTDuration)
	if DOTDuration > 0:
		damage_over_time(DOTDamage, DOTDuration)
	else: DOT_Timer.stop()
