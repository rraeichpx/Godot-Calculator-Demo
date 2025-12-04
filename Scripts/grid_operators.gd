extends GridContainer

var font := preload("res://Assets/fonts/ShareTech-Regular.ttf")
var display

func _ready():
	# DISPLAY NODE'A ULAŞ
	display = get_node("/root/Main/Display")

	columns = 4

	var operators = ["+", "-", "×", "÷"]

	for i in range(4):
		var btn := Button.new()

		btn.text = operators[i]
		btn.name = "op_" + operators[i]

		# EXPAND
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL

		# FONT
		btn.add_theme_font_override("font", font)
		btn.add_theme_font_size_override("font_size", 48)

		# MARGIN
		var style := StyleBoxFlat.new()
		btn.add_theme_stylebox_override("normal", style)

		btn.focus_mode = Control.FOCUS_NONE

		# --- DÜZELTME BURADA ---
		# Eskiden: display.append_number(operators[i]) yazıyordu.
		# Olması gereken: display.append_operator(operators[i])
		btn.pressed.connect(func():
			get_node("/root/Main").play_click()
			display.append_operator(operators[i]) 
		)
		# -----------------------

		add_child(btn)
