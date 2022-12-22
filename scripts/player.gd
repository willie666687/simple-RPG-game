extends KinematicBody2D

export var speed = 250
var looking = "back"
export var fighting = false
export var started = false
var enemy
func _ready():
	pass

func move(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
	if Input.is_action_pressed("move_back"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if velocity.x > 0:
		$AnimatedSprite.animation = "right_walk"
		looking = "right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "left_walk"
		looking = "left"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "back_walk"
		looking = "back"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "forward_walk"
		looking = "forward"
	elif looking == "right":
		$AnimatedSprite.animation = "right_afk"
	elif looking == "left":
		$AnimatedSprite.animation = "left_afk"
	elif looking == "back":
		$AnimatedSprite.animation = "back_afk"
	elif looking == "forward":
		$AnimatedSprite.animation = "forward_afk"
# warning-ignore:standalone_expression
	move_and_slide(velocity)*delta

func _process(_delta):
	# waiting start
	if fighting == true && started == false:
		if $"/root/Ui/Timer".time_left == 0:
			var scene = load("res://scenes/battle_UI.tscn")
			var instance = scene.instance()
			instance.enemy = enemy
			call_deferred("add_child",instance)
			started = true
		pass
	pass
func _physics_process(delta):
	move(delta)
	pass
