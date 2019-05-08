extends RigidBody2D

export var health = 10
export var speed = .8
onready var origin = global_position

enum {HOME, CHASE, IDLE, STUNNED}

var state = HOME
var velocity = Vector2(0,0)

var idle_timer
var stun_timer

signal killed(id)

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		queue_free()
	
	match state:
		HOME:
			if global_position.distance_to(origin) > 4:
				velocity = (origin - global_position).normalized()
#				move_and_slide(velocity * speed)
			else:
				state = IDLE
		CHASE:
			var player_pos = Global.player.global_position
			velocity = (player_pos - global_position).normalized()
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