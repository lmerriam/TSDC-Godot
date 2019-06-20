extends Entity
class_name Enemy

onready var origin = $Enemy.global_position

enum {HOME, CHASE, IDLE, STUNNED}

var state = HOME
var velocity = Vector2(0,0)
var mob: Array

var health = 10

var idle_timer
var stun_timer

signal killed(id)

func _ready():
	set_stat_base("speed", 1)

func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		call_deferred("queue_free")
	
	match state:
		HOME:
			if $Enemy.global_position.distance_to(origin) > 4:
				velocity = (origin - $Enemy.global_position).normalized() * get_stat("speed")
			else:
				state = IDLE
		CHASE:
			var player_pos = Global.player_character.global_position
			velocity = (player_pos - $Enemy.global_position).normalized() * get_stat("speed")
		IDLE:
			velocity = Vector2(0,0)
			if Global.player_character.global_position.distance_to($Enemy.global_position) < 175:
				state = CHASE
			elif $Enemy.global_position.distance_to(origin) < 24:
				state = HOME
		STUNNED:
			stun_timer -= delta
			velocity = Vector2(0,0)
			if stun_timer <= 0:
				state = IDLE
	
	$Enemy.velocity = velocity

func receive_attack(atk_resource):
	var damage = atk_resource.damage
	var knockback = atk_resource.knockback
	var group = atk_resource.group
	var buffs = atk_resource.buffs
	
	if not is_in_group(group):
		# Take damage
		health -= damage
		
		# Activate statuses from buffs
		if buffs:
			for buff in buffs:
				
				# Check for existing status from this buff
				var status_already_exists = false
				for status in status_current:
					if status.buff == buff:
						status_already_exists = true
						status.properties = buff.properties.duplicate()
				
				# Add new status
				if not status_already_exists:
					add_status(buff.new_status(self, group))
		
		# Set state to chase
		state = CHASE
		
		# Take knockback
		if knockback:
			var angle = Global.player_character.global_position.angle_to_point($Enemy.global_position)
			var kb = -Vector2(cos(angle), sin(angle)) * knockback
			knockback(kb)
		
		# Alert others in mob
		# TODO: signalize the following
		if mob:
			for enemy in mob:
				if enemy.state != STUNNED:
					enemy.state = CHASE
		return true
		
	else:
		return false

func add_status(status):
	.add_status(status)
	$Enemy.add_child(status)

func _on_AggroRadius_body_entered(body):
	if body == Global.player_character and state != STUNNED:
		self.state = CHASE

func _on_ChaseRadius_body_exited(body):
	if body == Global.player_character and state != STUNNED:
		self.state = HOME

func _on_Hitbox_area_entered(area):
	if area is AttackArea:
		if receive_attack(area.attack_resource):
			area.attack_successful(self)

func knockback(vector):
	$Enemy.apply_central_impulse(vector)
	state = STUNNED
	stun_timer = 1