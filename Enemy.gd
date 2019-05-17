extends RigidBody2D

export var health = 10
export var speed = .8
onready var origin = global_position

enum {HOME, CHASE, IDLE, STUNNED}

var state = HOME
var velocity = Vector2(0,0)

var idle_timer
var stun_timer
var status_current = []
var stats = {speed = 1}
var stat_modifiers = {}

signal killed(id)

func _ready():
	var cold = Status.Cold.new()
	cold.init(5,.1)
	cold.apply(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		queue_free()
	
	match state:
		HOME:
			if global_position.distance_to(origin) > 4:
				velocity = (origin - global_position).normalized() * get_stat("speed")
#				move_and_slide(velocity * speed)
			else:
				state = IDLE
		CHASE:
			var player_pos = Global.player.global_position
			velocity = (player_pos - global_position).normalized() * get_stat("speed")
#			move_and_slide(velocity * speed)
		IDLE:
			velocity = Vector2(0,0)
		STUNNED:
			stun_timer -= delta
			velocity = Vector2(0,0)
			if stun_timer <= 0:
				state = IDLE

func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x += velocity.x
	t.origin.y += velocity.y
	state.set_transform(t)

func take_damage(damage):
	health -= damage

func _on_AggroRadius_body_entered(body):
	if body == Global.player and state != STUNNED:
		self.state = CHASE

func _on_ChaseRadius_body_exited(body):
	if body == Global.player and state != STUNNED:
		self.state = HOME

func knockback(vector):
	apply_central_impulse(vector)
	state = STUNNED
	stun_timer = .5

func apply_status(status):
	status_current.append(status)
	add_child(status)

func remove_status(status):
	status_current.erase(status)

func get_stat(stat):
	var value = stats[stat]
	var mod = get_modifier_total(stat)
	return value * mod

func add_modifier(stat,id,value):
	if !stat_modifiers.has(stat):
		stat_modifiers[stat] = {}
	stat_modifiers[stat][id] = value

func get_modifier_total(stat):
	var value = 1
	var mods = stat_modifiers[stat]
	for mod in mods:
		value *= mods[mod]
	return value

func remove_modifier(stat, id):
	stat_modifiers[stat].erase(id)