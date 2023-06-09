extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

# PUBLIC

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the\nCreeps!"
	$TitleScreenImg1.show()
	$TitleScreenImg2.show()
	
	$ScoreLabel.hide()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

# PRIVATE

# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreenImg1.animation = "default"
	$TitleScreenImg1.play()
	$TitleScreenImg2.animation = "default"
	$TitleScreenImg2.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	$TitleScreenImg1.hide()
	$TitleScreenImg2.hide()
	$ScoreLabel.show()

	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
