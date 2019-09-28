extends Entity
class_name Enemy

export var attack_radius = 32
export var chase_radius = 256
export var aggro_radius = 128
export var origin_radius = 16
var in_origin_range = false
var in_aggro_range = false
var in_attack_range = false
var in_chase_range = false
var player_dis
var origin_dis

var stun_timer = 0

onready var origin = $Enemy.global_position

var mob: Array
var cooldown = 0

signal killed(id)

func _ready():
	set_stat_base("speed", 1)

func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		call_deferred("queue_free")
	
	# Check distances
	var player_pos = Global.player_character.global_position
	player_dis = $Enemy.global_position.distance_to(player_pos)
	origin_dis = $Enemy.global_position.distance_to(origin)
	
	in_aggro_range = false
	in_attack_range = false
	in_chase_range = false
	in_origin_range = false
	
	if player_dis < aggro_radius:
		in_aggro_range = true
	
	if player_dis < chase_radius:
		in_chase_range = true
	
	if player_dis < attack_radius:
		in_attack_range = true
	
	if origin_dis < origin_radius:
		in_origin_range = true

func receive_attack(atk_resource):
	var damage = atk_resource.stats.damage
	var knockback = atk_resource.stats.knockback
	var stagger = atk_resource.stats.stagger
	var group = atk_resource.group
	var buffs = atk_resource.buffs
	
	if not is_in_group(group):
		# Take damage
		set_health(health - damage)
		
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
		
		# Take knockback
		if knockback:
			var angle = Global.player_character.global_position.angle_to_point($Enemy.global_position)
			var kb = -Vector2(cos(angle), sin(angle)) * knockback
			knockback(kb)
		
		if stagger:
			$Enemy/StateMachine._change_state("stunned")
			stun_timer = stagger
		
		return true
		
	else:
		return false

func move_toward_point(vec):
	$Enemy.velocity = (vec - $Enemy.global_position).normalized() * get_stat("speed")

func add_status(status):
	.add_status(status)
	$Enemy.add_child(status)

func _on_Hitbox_area_entered(area):
	if area is AttackArea:
		if receive_attack(area.properties):
			area.attack_successful(self)

func knockback(vector):
	$Enemy.apply_central_impulse(vector)
