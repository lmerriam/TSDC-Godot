extends CanvasLayer

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_released("ui_inventory"):
		$Inventory.visible = !$Inventory.visible