extends Area2D

signal hit

@export var speed=400

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	# Hello, this is a commit from Richie


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector. (0,0)
	if Input.is_action_pressed("d"):
		velocity.x += 1 # (1,0)
	if Input.is_action_pressed("a"):
		velocity.x -= 1
	if Input.is_action_pressed("s"):
		velocity.y += 1
	if Input.is_action_pressed("w"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # (400,0)
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
			
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)	

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
