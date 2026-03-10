# SA-MP PLN Job System ⚡

Filterscript job **PLN (Perbaikan Listrik)** untuk server **SA:MP** menggunakan bahasa pemrograman **Pawn**.

Script ini membuat sistem dimana listrik di beberapa lokasi bisa **padam secara acak**, dan pemain yang bertugas sebagai **teknisi PLN** harus memperbaikinya.

---

# Fitur

- ⚡ Sistem pemadaman listrik otomatis
- ⏱ Pemadaman terjadi setiap **3 menit**
- 📍 Banyak lokasi listrik
- 🔧 Perbaikan listrik dengan **animasi**
- 👷 Skin teknisi PLN saat duty
- 📋 Dialog untuk melihat status listrik
- 📍 Checkpoint menuju lokasi perbaikan
- 💰 Reward uang setelah memperbaiki listrik
- 🚫 Anti bug (repair spam, lokasi salah, dll)
- ⚡ Banyak lokasi bisa padam sekaligus

---

# Sistem Kerja

1. Server menjalankan timer setiap **3 menit**.

2. Sistem akan memilih **lokasi listrik secara acak**.

3. Jika lokasi tersebut normal maka akan menjadi **PADAM**.

4. Teknisi PLN dapat melihat lokasi listrik menggunakan command:

```
/listlistrik
```

5. Player memilih lokasi dari dialog dan mendapatkan **checkpoint**.

6. Player menuju lokasi lalu menggunakan command:

```
/perbaikilistrik
```

7. Player akan melakukan **animasi perbaikan selama 20 detik**.

8. Setelah selesai:
- listrik kembali normal
- player mendapatkan **$50.000**

---

# Command

### Duty PLN

```
/dutypln
```

Mengaktifkan atau menonaktifkan duty teknisi PLN.

Saat duty:
- player mendapatkan **skin teknisi**
- dapat memperbaiki listrik

---

### Melihat Status Listrik

```
/listlistrik
```

Menampilkan dialog berisi daftar lokasi listrik:

Contoh:

```
Lokasi 1 (PADAM)
Lokasi 2 (Normal)
Lokasi 3 (PADAM)
Lokasi 4 (Normal)
Lokasi 5 (Normal)
```

---

### Memperbaiki Listrik

```
/perbaikilistrik
```

Digunakan saat player berada di lokasi listrik yang padam.

Proses:
- player tidak bisa bergerak
- animasi perbaikan berjalan
- durasi 20 detik

---

# Lokasi Listrik

Lokasi listrik berada di koordinat berikut:

```
1446.46, -934.31, 36.35
1044.85, -1362.66, 13.57
-118.76, -1239.36, 2.78
672.04, -590.57, 16.33
218.27, -291.49, 1.57
```

Lokasi dapat diubah langsung di dalam script.

---

# Cara Install

1. Download atau clone repository ini

```
git clone https://github.com/DelfinIbnKadafi/Job-PLN
```

2. Masukkan file `.pwn` ke folder:

```
filterscripts/
```

3. Compile script menggunakan **Pawn Compiler**

4. Tambahkan di `server.cfg`

```
filterscripts pln
```

5. Jalankan server.

---

# Requirements

- SA-MP Server
- Pawn Compiler
- Include:

```
zcmd
a_samp
```

---

# Kontribusi

Kontribusi sangat diterima.

Jika ingin menambahkan fitur seperti:

- blackout satu kota
- object tiang listrik
- kendaraan PLN
- sistem level teknisi

silakan buat **Fork**.

---

# License

Free to use untuk server SA-MP.

```
Made by Delfin
```
