# **Godot Calculator Project / Godot Taschenrechner / Godot Hesap Makinesi**

Welcome to the **Godot Calculator Project**. This repository contains a fully responsive scientific calculator built with Godot Engine 4.x. It features basic arithmetic, advanced functions (\!, √, x²), and a dynamic UI that adapts to mobile screens.

**Select Language / Sprache Wählen / Dil Seçiniz:**

* [🇺🇸 English Documentation](https://www.google.com/search?q=%23english-documentation)  
* [🇩🇪 Deutsche Dokumentation](https://www.google.com/search?q=%23deutsche-dokumentation)  
* [🇹🇷 Türkçe Dokümantasyon](https://www.google.com/search?q=%23t%C3%BCrk%C3%A7e-dok%C3%BCmantasyon)

# **🇺🇸 English Documentation**

## **1\. Project Overview & Node Architecture**

This project utilizes a Control based node structure to ensure responsiveness on various mobile screen sizes (portrait mode).

### **Core Nodes & Usage:**

* **Control (Main):** The root node. It uses the Full Rect layout preset to ensure the app covers the entire screen, regardless of resolution.  
* **TextureRect:** Used for the background image. The **Expand Mode** is set to Keep Aspect Covered to ensure the background scales without distortion or black bars.  
* **VBoxContainer:** A vertical layout container that stacks the Display (Label) and the Keypad (GridContainer) automatically.  
* **GridContainer:** Arranges buttons in a grid (rows and columns).  
  * *Note:* The Size Flags \> Vertical \> Expand property is enabled to allow buttons to fill the remaining screen space.  
* **Label:** Displays the calculation text. Uses TextServer settings to handle text wrapping and clipping.  
* **Button:** Interactive elements. They are connected to scripts via the pressed() signal to trigger logic functions like append\_number() or calculate\_result().  
* **AudioStreamPlayer:** Handles UI sound effects. It is triggered by a global function play\_click() in the main script whenever a button is pressed.

### **File Organization:**

* **Scripts (.gd):** Logic is decoupled. grid\_numbers.gd handles numeric input, while display.gd manages the screen logic.  
* **Assets:** Fonts (.ttf) and Images (.png) are stored in an Assets/ folder to keep the root directory clean.

## **2\. Git Best Practices for Godot**

To maintain a clean repository and ensure effective version control, follow these guidelines.

### **A. Files to Ignore (.gitignore)**

Godot generates temporary files that should **not** be committed. Create a .gitignore file with the following:

```gitignore
\# Godot 4+ specific imports and cache  
.godot/  
.import/

\# Export presets (may contain sensitive paths/passwords)  
export\_presets.cfg

\# Mono/C\# builds (if used)  
.mono/  
\*.sln  
\*.csproj

\# OS specific files  
.DS\_Store  
Thumbs.db
```

### **B. Godot Settings for Git**

* **Text-Based Files:** Godot 4 saves scenes (.tscn) and resources (.tres) as text by default. **Do not** change this to binary (.scn) format, as binary files cannot be diffed (compared) in Git.  
* **Force Text Resource:** Ensure *Editor Settings \> Filesystem \> File Server \> Text Serialization* is enabled (default).

## **3\. Android Build Instructions**

Steps to generate a signed APK for Android devices.

### **Step 1: Generate Debug Keystore**

Android requires a keystore to sign the app. Open your terminal and run:

```cmd
keytool \-genkey \-v \-keystore debug.keystore \-storepass android \-alias androiddebugkey \-keypass android \-keyalg RSA \-keysize 2048 \-validity 10000
```

*Save the generated debug.keystore file in a safe location outside your project folder.*

### **Step 2: Configure Editor**

1. Go to **Editor \> Editor Settings \> Export \> Android**.  
2. Set **Debug Keystore** to the path of your debug.keystore file.  
3. Set **Android SDK Path** to your local Android SDK location.

### **Step 3: Export Project**

1. Go to **Project \> Export**.  
2. Click **Add...** and select **Android**.  
3. Check the **"Export With Debug"** box (for testing purposes).  
4. Click **Export Project** to save the .apk.

*(Ensure Project Settings \> Display \> Window \> Handheld \> Orientation is set to portrait for best mobile experience.)*

\<a name="deutsche-dokumentation"\>\</a\>

# **🇩🇪 Deutsche Dokumentation**

## **1\. Projektübersicht & Knoten-Architektur**

Dieses Projekt ist ein wissenschaftlicher Taschenrechner auf Basis der Godot Engine 4.x. Er verwendet eine Control-basierte Struktur für responsive mobile Layouts.

### **Wichtige Knoten (Nodes):**

* **Control (Main):** Der Wurzelknoten. Verwendet das Full Rect Layout, damit die App den gesamten Bildschirm ausfüllt.  
* **TextureRect:** Zeigt das Hintergrundbild an. Der Modus Keep Aspect Covered sorgt dafür, dass das Bild ohne Verzerrung skaliert wird.  
* **VBoxContainer:** Ordnet Elemente (Display und Tastenfeld) vertikal untereinander an.  
* **GridContainer:** Organisiert Buttons in einem Gitter (Zeilen/Spalten).  
  * *Hinweis:* Size Flags \> Vertical \> Expand ist aktiviert, damit die Tasten den leeren Bildschirmplatz füllen.  
* **Label:** Zeigt das Ergebnis an.  
* **Button:** Führt bei Betätigung (pressed() Signal) Logik-Skripte aus.  
* **AudioStreamPlayer:** Spielt Klickgeräusche ab, gesteuert durch eine globale Funktion.

## **2\. Git Best Practices für Godot**

Für eine saubere Versionsverwaltung in Git sollten folgende Regeln beachtet werden.

### **A. Zu ignorierende Dateien (.gitignore)**

Godot erstellt temporäre Dateien, die **nicht** hochgeladen werden sollten. Inhalt für .gitignore:

```gitignore
\# Godot Cache und Importe  
.godot/  
.import/

\# Export-Einstellungen (Sicherheit)  
export\_presets.cfg

\# Systemdateien  
.DS\_Store  
Thumbs.db
```

### **B. Einstellungen für Diffs**

* **Textformat:** Godot 4 speichert Szenen (.tscn) standardmäßig als Text. Ändern Sie dies nicht in Binärform (.scn), da Git sonst Änderungen nicht Zeile für Zeile anzeigen kann ("Diffing").

## **3\. Android APK Erstellung**

Anleitung zum Erstellen einer signierten APK-Datei.

### **Schritt 1: Keystore Erstellen**

Führen Sie diesen Befehl im Terminal aus (JDK erforderlich):

```cmd
keytool \-genkey \-v \-keystore debug.keystore \-storepass android \-alias androiddebugkey \-keypass android \-keyalg RSA \-keysize 2048 \-validity 10000
```

### **Schritt 2: Editor Konfiguration**

1. Navigieren Sie zu **Editor \> Editor Settings \> Export \> Android**.  
2. Setzen Sie den Pfad für **Debug Keystore** auf Ihre erstellte Datei.

### **Schritt 3: Exportieren**

1. Gehen Sie zu **Project \> Export \> Android**.  
2. Aktivieren Sie **"Export With Debug"**.  
3. Klicken Sie auf **Export Project**.

*(Stellen Sie sicher, dass in den Projekteinstellungen die Orientierung auf portrait gesetzt ist.)*

\<a name="türkçe-dokümantasyon"\>\</a\>

# **🇹🇷 Türkçe Dokümantasyon**

## **1\. Proje Özeti ve Godot Kullanımı**

Bu proje, Godot Engine 4.x ile geliştirilmiş bilimsel bir hesap makinesidir. Mobil cihazlarda ekran boyutu ne olursa olsun tam uyum sağlaması (Responsive) için Control node'ları üzerine kurulmuştur.

### **Temel Node'lar ve Özellikleri:**

* **Control (Main):** Projenin ana (kök) node'udur. Full Rect (Tam Ekran) ayarı kullanılarak uygulamanın tüm ekranı kaplaması sağlanmıştır.  
* **TextureRect:** Arkaplan görselini tutar. Görselin yamulmaması için **Expand Mode** ayarı Keep Aspect Covered (Oranı Koru ve Kapla) olarak seçilmiştir.  
* **VBoxContainer:** İçine koyulan öğeleri (Ekran ve Tuşlar) dikey olarak, otomatik hizalar.  
* **GridContainer:** Tuşları satır ve sütun mantığıyla dizer.  
  * *İpucu:* Tuşların ekranın kalanını doldurması için **Size Flags \> Vertical \> Expand** özelliği açılmıştır.  
* **Label:** Hesaplamaların gösterildiği metin alanıdır.  
* **Button:** Tıklanabilir butonlardır. pressed() sinyali ile script dosyalarına bağlanır ve append\_number gibi fonksiyonları tetikler.  
* **AudioStreamPlayer:** Ses efektlerini yönetir. Her tıklandığında play() fonksiyonu ile sesi çalar.

### **Dosya Düzeni:**

* **Scripts (.gd):** Kodlar tek bir dosyada toplanmak yerine, ilgili parçalara (grid\_numbers.gd, display.gd) bölünmüştür.  
* **Assets:** Fontlar ve görseller Assets/ klasöründe tutularak proje düzeni sağlanmıştır.

## **2\. Godot için Git En İyi Uygulamalar**

Projenizi Git üzerinde barındırırken temiz bir geçmiş ve doğru versiyon kontrolü için şunlara dikkat edin.

### **A. Yok Sayılması Gerekenler (.gitignore)**

Godot proje klasöründe oluşan geçici dosyaları Git'e atmamalısınız. Ana dizine şu içeriğe sahip bir .gitignore dosyası ekleyin:

```gitignore
\# Godot 4 Cache ve Import dosyaları (Gereksiz yer kaplar)  
.godot/  
.import/

\# Export ayarları (Gizli şifreler içerebilir, yüklemeyin)  
export\_presets.cfg

\# İşletim sistemi dosyaları  
.DS\_Store  
Thumbs.db
```

### **B. Versiyon Takibi Ayarları**

Git üzerinde yapılan değişiklikleri (Diff) görebilmek için dosyaların okunabilir olması gerekir.

* **Metin Tabanlı Kayıt:** Godot 4 varsayılan olarak sahneleri .tscn formatında (metin) kaydeder. Bunu asla .scn (binary) formatına çevirmeyin. Metin formatı sayesinde Git üzerinde "Hangi satırda ne değişmiş?" sorusunun cevabını görebilirsiniz.

## **3\. Android APK Build Alma Rehberi**

Projeyi telefonda çalıştırmak (APK çıktısı almak) için adımlar:

### **Adım 1: Debug Keystore (İmza) Oluşturma**

Android, imzasız uygulamaları yüklemez. Terminali açın ve şu komutu girin (Bilgisayarınızda Java yüklü olmalıdır):

```cmd
keytool \-genkey \-v \-keystore debug.keystore \-storepass android \-alias androiddebugkey \-keypass android \-keyalg RSA \-keysize 2048 \-validity 10000
```

*Oluşan debug.keystore dosyasını güvenli, sabit bir klasöre kaydedin.*

### **Adım 2: Godot Ayarları**

1. **Editor \> Editor Settings \> Export \> Android** menüsüne gidin.  
2. **Debug Keystore** kısmına, az önce oluşturduğunuz dosyanın yolunu seçin.  
3. **Android SDK Path** kısmının doğru olduğundan emin olun.

### **Adım 3: Çıktı Alma (Export)**

1. Üst menüden **Project \> Export** seçeneğine tıklayın.  
2. **Add...** diyerek **Android** seçeneğini ekleyin.  
3. Test sürümü olduğu için **"Export With Debug"** kutucuğunu işaretleyin.  
4. **Export Project** butonuna basarak APK dosyanızı kaydedin.

*(Not: Tam ekran deneyimi için **Project Settings \> Display \> Window \> Handheld \> Orientation** ayarını portrait yapmayı unutmayın.)*
