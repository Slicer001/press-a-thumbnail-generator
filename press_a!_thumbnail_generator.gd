extends Control

var target_picture: Image

#inputs box
@onready var inputs: VBoxContainer = $Inputs
@onready var web_inputs: VBoxContainer = $WebInputs

#file dialogs
@onready var choose_file_dialog: FileDialog = $ChooseFileDialog
@onready var save_file_dialog: FileDialog = $SaveFileDialog

#image parts
@onready var texture_rect: TextureRect = $TextureRect
@onready var first_label: Label = $Display/FirstLabel
@onready var second_label: Label = $Display/SecondLabel

#web inputs
@onready var image_download: Node = $ImageDownload

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func save_image(path: String) -> void:
	# Remove the inputs
	inputs.hide()
	web_inputs.hide()
	
	# Wait for the frame to finish rendering
	await RenderingServer.frame_post_draw
	
	# Capture the viewport
	var img = get_viewport().get_texture().get_image()
	
	# Save to user directory
	img.save_png(path)
	print("Screenshot saved to: ", path)
	
	# Return the inputs
	inputs.show()
	web_inputs.show()

func update_font_size(target: Label, font_size: int) -> void:
	target.add_theme_font_size_override("font_size", font_size)
	if target.size.x < get_viewport_rect().size.x:
		return
	update_font_size(target, font_size-8)

#choose image
func _on_choose_a_file_button_pressed() -> void:
	choose_file_dialog.popup_file_dialog()

func _on_file_dialog_file_selected(path: String) -> void:
	target_picture = Image.load_from_file(path)
	texture_rect.texture = ImageTexture.create_from_image(target_picture)

#edit text
func _on_first_line_edit_text_changed(new_text: String) -> void:
	first_label.text = new_text.to_lower()
	update_font_size(first_label, 192)

func _on_second_line_edit_text_changed(new_text: String) -> void:
	second_label.text = "(" + new_text.to_lower() + ")"
	update_font_size(second_label, 96)

#save file
func _on_save_button_pressed() -> void:
	save_file_dialog.popup_file_dialog()

func _on_save_file_dialog_file_selected(path: String) -> void:
	save_image(path)

#pasting links or images
func _on_paste_button_pressed() -> void:
	var clipboard = DisplayServer.clipboard_get()
	if clipboard is String:
		image_download.download_image(clipboard)

func _on_paste_image_button_pressed() -> void:
	var clipboard = DisplayServer.clipboard_get_image()
	if clipboard is Image:
		texture_rect.texture = ImageTexture.create_from_image(clipboard)

#remove HUD for screenshots
func _on_screenshot_mode_button_pressed() -> void:
	inputs.hide()
	web_inputs.hide()
