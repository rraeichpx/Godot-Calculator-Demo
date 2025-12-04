extends Label

var display_text := ""

# Operatörleri burada tanımladım, böylece kontrol etmesi kolay olur
const OPERATORS = ["+", "-", "×", "÷"]

func _ready():
	text = "0"
	display_text = "0" # Hesap makinesi genelde 0 ile başlar
	autowrap_mode = TextServer.AUTOWRAP_OFF
	clip_text = true


# -----------------------------
#    SAYI EKLEME MANTIĞI
# -----------------------------
func append_number(num):
	num = str(num)

	# Ekranda sadece "0" varsa ve yeni gelen sayı "0" değilse
	# O sıfırı silip yeni sayıyı yazmalıyız.
	if display_text == "0":
		display_text = num
	else:
		display_text += num

	text = display_text


# -----------------------------
#    OPERATÖR EKLEME MANTIĞI
# -----------------------------
func append_operator(op):
	# Kural 1: Ekran boşsa operatör yazılamasın
	if display_text == "":
		return

	# Ekranın son karakterini alıyoruz
	var last_char = display_text.substr(display_text.length() - 1, 1)

	# Kural 2: Son karakter zaten bir operatör mü?
	if last_char in OPERATORS:
		# Evet operatör. O zaman sonuncuyu sil, yerine yenisini koy (Değiştirme mantığı)
		display_text = display_text.substr(0, display_text.length() - 1)
		display_text += op
	else:
		# Hayır, son karakter sayı. Normal şekilde ekle.
		display_text += op

	text = display_text


# -----------------------------
#  TEMİZLEME
# -----------------------------
func clear_display():
	# Temizleyince genelde 0'a döner, boş kalması yerine 0 dönmesi daha UX dostudur.
	# Ama senin isteğine göre tamamen boşaltabilirsin.
	# Burayı "0" yaparsan, operatör engeli çalışmaz (çünkü sayı var sayılır).
	# O yüzden boş bırakıyorum, append_number ilk tuşlamayı halleder.
	display_text = "" 
	text = ""


# -----------------------------
#  DİREKT YAZDIRMA
# -----------------------------
func set_text_direct(new_text):
	display_text = str(new_text)
	text = display_text


# -----------------------------
#  HATA GÖSTERME
# -----------------------------
func show_error(msg):
	self.modulate = Color(1, 0.3, 0.3)
	text = msg
	await get_tree().create_timer(1.0).timeout
	self.modulate = Color(1, 1, 1)
	clear_display()
	
	# display.gd dosyasına eklenecek yeni fonksiyon

# -----------------------------
#    NOKTA (VİRGÜL) EKLEME MANTIĞI
# -----------------------------
func append_dot():
	# Kural 1: Eğer ekran boşsa veya son karakter bir operatörse
	# "." yerine "0." yazmak daha şıktır (Örn: .5 değil 0.5)
	if display_text == "" or display_text.right(1) in OPERATORS:
		display_text += "0."
		text = display_text
		return

	# Kural 2: Şu an yazılan son sayıda zaten nokta var mı?
	# Bunu anlamak için operatörlerden sonrasını ayıklamamız lazım.
	
	var temp_text = display_text
	# Tüm operatörleri geçici olarak '|' işaretine çevirelim ki split yapabilelim
	for op in OPERATORS:
		temp_text = temp_text.replace(op, "|")
	
	# Parçalara ayır ve son parçayı (şu anki sayıyı) al
	var parts = temp_text.split("|")
	var current_number = parts[parts.size() - 1]
	
	# Eğer son sayıda zaten nokta varsa, hiçbir şey yapma
	if "." in current_number:
		return

	# Yoksa noktayı koy
	display_text += "."
	text = display_text
	
	# display.gd dosyasının en altına ekle

# -----------------------------
#  ÖZEL MATEMATİK İŞLEMLERİ
# -----------------------------

# Yardımcı fonksiyon: Sonucu ekrana temiz yazar (5.0 ise 5, 5.2 ise 5.2)
func _update_result(val):
	if typeof(val) == TYPE_FLOAT and val == int(val):
		set_text_direct(str(int(val)))
	else:
		set_text_direct(str(val))

# 1. FAKTORİYEL (!)
func calculate_factorial():
	# Operatör kontrolü
	for op in OPERATORS:
		if op in display_text:
			show_error("INVALID CASE")
			return
	
	var n = int(display_text)
	if n < 0:
		show_error("INVALID CASE") # Negatif faktoriyel olmaz
		return
		
	# Basit faktoriyel hesabı
	var result = 1
	for i in range(1, n + 1):
		result *= i
	
	_update_result(result)

# 2. KAREKÖK (√)
func calculate_sqrt():
	for op in OPERATORS:
		if op in display_text:
			show_error("INVALID CASE")
			return
			
	var n = float(display_text)
	if n < 0:
		show_error("INVALID CASE") # Negatif kök olmaz (reel sayılarda)
		return
		
	_update_result(sqrt(n))

# 3. KARE ALMA (x²)
func calculate_square():
	for op in OPERATORS:
		if op in display_text:
			show_error("INVALID CASE")
			return
			
	var n = float(display_text)
	_update_result(n * n)
