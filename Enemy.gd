extends RigidBody2D
class_name Enemy

onready var origin = global_position

enum {HOME, CHASE, IDLE, STUNNED}

var state = HOME
var velocity = Vector2(0,0)
var mob: Array

var health = 10

var idle_timer
var stun_timer
var status_current = []

var components = ComponentLibrary.init_components(self,[ComponentStats])
var stats_component = components[ComponentStats]

signal killed(id)

func _ready():
	var cold = Status.Cold.new()
	cold.init(5,.1)
	cold.apply(self)
	stats_component.set_stat_base("speed", 1)
	stats_component.set_stat_base("max_health", health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		queue_free()
	
	match state:
		HOME:
			if global_position.distance_to(origin) > 4:
				velocity = (origin - global_position).normalized() * stats_component.get_stat("speed")
#				move_and_slide(velocity * speed)
			else:
				state = IDLE
		CHASE:
			var player_pos = Global.player.global_position
			velocity = (player_pos - global_position).normalized() * stats_component.get_stat("speed")
#			move_and_slide(velocity * speed)
		IDLE:
			velocity = Vector2(0,0)
			if Global.player.global_position.distance_to(global_position) < 175:
				state = CHASE
			elif global_position.distance_to(origin) < 24:
				state = HOME
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
#	stats_component.add_to_stat_base("health",-damage)
	health -= damage
	state = CHASE
	if mob:
		for enemy in mob:
			if enemy.state != STUNNED:
				enemy.state = CHASE

func _on_AggroRadius_body_entered(body):
	if body == Global.player and state != STUNNED:
		self.state = CHASE

func _on_ChaseRadius_body_exited(body):
	if body == Global.player and state != STUNNED:
		self.state = HOME

func knockback(vector):
	apply_central_impulse(vector)
	state = STUNNED
	stun_timer = 1

func apply_status(status):
	status_current.append(status)
	add_child(status)

func remove_status(status):
	status_current.erase(status)

func get_component_stats():
	return stats_component