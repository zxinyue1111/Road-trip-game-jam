extends Control

@onready var text_label = $DialogueBox/Label  # Make sure the path is correct

var text_speed = 0.05  # Normal speed
var fast_text_speed = 0.01  # Faster speed when skipping
var skipping = false  # Flag for skipping
var current_speed = text_speed  # Default speed

func _ready():
	text_label.clear()
	show_scrolling_text([
		"hello world this is a test dialogue AAAAAAAAAAAAAAAAAAA", 
		"yippieee", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AAAAAAAAAAAAAAAAAAAAAA"
	])

func show_scrolling_text(dialogue_lines: Array):
	for line in dialogue_lines:
		skipping = false
		current_speed = text_speed  # Reset speed for each new line
		await display_text(line)  # Wait for text to display
		await wait_for_input()  # Wait for player input before continuing

func display_text(full_text: String):
	text_label.text = full_text
	text_label.visible_characters = 0
	
	for i in range(full_text.length()):
		if Input.is_action_just_pressed("skip"):
			current_speed = fast_text_speed
		if skipping:  # If skipping is triggered, instantly show full text
			text_label.visible_characters = full_text.length()
			current_speed = text_speed
			return

		text_label.visible_characters = i + 1
		await get_tree().create_timer(current_speed).timeout  # Use dynamic speed
	
	text_label.visible_characters = full_text.length()

func wait_for_input():
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("skip"):
			if current_speed == text_speed:
				current_speed = fast_text_speed
				break  # Speed up text
			else:
				skipping = true  # Instantly show full text
				break
