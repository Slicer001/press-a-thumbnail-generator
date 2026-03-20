extends Node

@onready var first_line_edit: LineEdit = $"../Inputs/FirstLineEdit"
@onready var second_line_edit: LineEdit = $"../Inputs/SecondLineEdit"
@onready var image_link_line_edit: LineEdit = $"../WebInputs/HBoxContainer/ImageLinkLineEdit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_first_line_edit_focus_entered() -> void:
	DisplayServer.virtual_keyboard_show(first_line_edit.text)


func _on_first_line_edit_focus_exited() -> void:
	DisplayServer.virtual_keyboard_hide()


func _on_second_line_edit_focus_entered() -> void:
	DisplayServer.virtual_keyboard_show(second_line_edit.text)


func _on_second_line_edit_focus_exited() -> void:
	DisplayServer.virtual_keyboard_hide()


func _on_image_link_line_edit_focus_entered() -> void:
	DisplayServer.virtual_keyboard_show(image_link_line_edit.text)


func _on_image_link_line_edit_focus_exited() -> void:
	DisplayServer.virtual_keyboard_hide()
