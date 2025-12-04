extends Button

func _ready():
	text = "CALCULATE"
	focus_mode = Control.FOCUS_NONE

func _pressed():
	get_node("/root/Main").play_click()
	var display = get_node("/root/Main/Display") # ekran node'unun yolu (senin sahneye göre ayarla)
	var expr = display.display_text

	# 1) Boş ifadeye basılınca
	if expr == "" or expr == "0":
		display.show_error("INVALID CASE")
		return


	# 2) Ard arda operator var mı?
	if has_consecutive_operators(expr):
		display.show_error("INVALID CASE")
		return


	# 3) 0'a bölme kontrol
	if expr.find("÷0") != -1:
		display.show_error("INVALID CASE")
		return


	# 4) Matematiksel ifadeyi Godot'un eval sistemiyle çöz (× ve ÷ normal hale getirilir)
	var safe_expr = convert_to_math(expr)

	var result = ""
	var ok := true

	# eval güvenli şekilde çalışır, hata olursa ok false döner
	result = Expression.new()
	var parse_err = result.parse(safe_expr)

	if parse_err != OK:
		display.show_error("INVALID CASE")
		return

	var final = result.execute()
	if result.has_execute_failed():
		display.show_error("INVALID CASE")
		return

	# --- GÜNCELLEME BURADA ---
	# Gelen sonuç float mı int mi kontrol edelim
	# Eğer sonuç 5.0 gibi tam sayıya eşit bir float ise, int'e çevirip .0 atalım.
	
	if typeof(final) == TYPE_FLOAT and final == int(final):
		display.set_text_direct(str(int(final)))
	else:
		# Değilse (mesela 5.2 ise) olduğu gibi float yazsın
		display.set_text_direct(str(final))

# -------------------------
#  YARDIMCI FONKSİYONLAR
# -------------------------

func has_consecutive_operators(text):
	var ops = ["+", "-", "×", "÷"]
	for i in range(text.length() - 1):
		if text[i] in ops and text[i + 1] in ops:
			return true
	return false


func convert_to_math(text):
	text = text.replace("×", "*")
	text = text.replace("÷", "/")
	return text
