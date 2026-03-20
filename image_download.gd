extends Node

@onready var texture_rect: TextureRect = $"../TextureRect"

func download_image(url: String):
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _http_request_completed(result, _response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")

	var image = try_all_image_types(body)
	if not image:
		push_error("Couldn't load the image.")

	var texture = ImageTexture.create_from_image(image)

	# Display the image in a TextureRect node.
	texture_rect.texture = texture

func try_all_image_types(body) -> Image:
	var image = Image.new()
	
	var error
	error = image.load_bmp_from_buffer(body)
	if error == OK:
		return image
	error = image.load_dds_from_buffer(body)
	if error == OK:
		return image
	error = image.load_exr_from_buffer(body)
	if error == OK:
		return image
	error = image.load_jpg_from_buffer(body)
	if error == OK:
		return image
	error = image.load_ktx_from_buffer(body)
	if error == OK:
		return image
	error = image.load_png_from_buffer(body)
	if error == OK:
		return image
	error = image.load_svg_from_buffer(body)
	if error == OK:
		return image
	error = image.load_tga_from_buffer(body)
	if error == OK:
		return image
	error = image.load_webp_from_buffer(body)
	if error == OK:
		return image
	
	return null
