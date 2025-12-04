extends GridContainer

var font := preload("res://Assets/fonts/ShareTech-Regular.ttf")
var display

func _ready():
	# DISPLAY NODE'A ULAŞ
	display = get_node("/root/Main/Display")

	columns = 5
	
	# 1. KISIM: 0'dan 9'a SAYILAR
	for i in range(0, 10):
		var btn := Button.new()

		# SIZE
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL

		# MARGIN
		var style := StyleBoxFlat.new()
		btn.add_theme_stylebox_override("normal", style)

		# FOCUS OFF
		btn.focus_mode = Control.FOCUS_NONE

		# FONT
		btn.add_theme_font_override("font", font)
		btn.add_theme_font_size_override("font_size", 48)

		# TEXT
		btn.text = str(i)
		btn.name = "btn_" + str(i)

		# SIGNAL → DISPLAY’E YAZ
		btn.pressed.connect(func():
			get_node("/root/Main").play_click()
			display.append_number(i)
		)

		add_child(btn)


	# 2. KISIM: EKSTRA BUTONLAR (. ! √ x² C)
	var extra_buttons = [
		{"label": ".",  "func": "append_dot"},
		{"label": "!",  "func": "calculate_factorial"},
		{"label": "√",  "func": "calculate_sqrt"},
		{"label": "x²", "func": "calculate_square"},
		{"label": "C",  "func": "clear_display"}
	]

	for btn_data in extra_buttons:
		var btn := Button.new()
		
		# Görsel Ayarlar
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
		btn.focus_mode = Control.FOCUS_NONE
		
		var style := StyleBoxFlat.new()
		
		# C butonu fark edilsin diye hafif kırmızımsı, diğerleri gri
		if btn_data["label"] == "C":
			style.bg_color = Color(0.8, 0.2, 0.2, 1) 
		else:
			style.bg_color = Color(0.6, 0.6, 0.6, 1)
			
		btn.add_theme_stylebox_override("normal", style)
		btn.add_theme_font_override("font", font)
		btn.add_theme_font_size_override("font_size", 48)
		
		btn.text = btn_data["label"]
		btn.name = "btn_" + btn_data["label"]
		
		# Tıklama Olayı
		btn.pressed.connect(func():
			get_node("/root/Main").play_click()
			display.call(btn_data["func"])
		)
		
		add_child(btn)
