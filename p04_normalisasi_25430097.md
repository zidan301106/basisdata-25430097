# Tugas Mandiri Milestone Proyek 4: Normalisasi dan Skema Relasional Proyek SIAKAD

**Nama:** Muhammad Zidan Ilham  
**NPM:** 25430097  
**Dosen:** Dedi Irawan, S.Kom., M.T.I.  
**Tema Proyek:** Akademik   
 

---

## 1. Dokumen Sumber Proyek (Titik Awal UNF)

Dokumen sumber utama yang dianalisis dari Pertemuan 2 adalah **Formulir Kartu Rencana Studi (KRS)**. Formulir ini mencatat identitas mahasiswa, semester perkuliahan, serta rincian kelas/mata kuliah yang diambil dalam satu semester.

### Unnormalized Form (UNF)
Pada bentuk UNF, seluruh elemen data tersimpan dalam satu relasi tunggal yang memuat kelompok berulang (*repeating group*) pada bagian daftar mata kuliah yang diambil mahasiswa:

> **KRS_UNF** (`no_krs`, `nim`, `nama_mahasiswa`, `prodi`, `nidn_pa`, `nama_dosen_pa`, `tahun_akademik`, `semester`, `tanggal_krs`, `status_persetujuan`, { `kode_kelas`, `kode_mk`, `nama_mk`, `sks`, `semester_paket`, `nidn_pengampu`, `nama_dosen_pengampu`, `ruang`, `jadwal_hari_jam`, `nilai_angka`, `nilai_huruf` }, `total_sks`)

---

## 2. Dependensi Fungsional (Functional Dependency / FD)

Dependensi fungsional diturunkan secara logis dari aturan bisnis (AB-xx) proyek SIAKAD:

* **FD1:** `no_krs` $\rightarrow$ `nim`, `tahun_akademik`, `semester`, `tanggal_krs`, `status_persetujuan` *(Berdasarkan AB-03 dan AB-04)*
* **FD2:** `nim` $\rightarrow$ `nama_mahasiswa`, `prodi`, `no_hp`, `email`, `status_akademik`, `nidn_pa` *(Berdasarkan AB-01 dan AB-04)*
* **FD3:** `nidn` $\rightarrow$ `nama_dosen`, `no_hp`, `email`, `status_dosen` *(Berdasarkan AB-02)*
* **FD4:** `kode_mk` $\rightarrow$ `nama_mk`, `sks`, `semester_paket`
* **FD5:** `kode_kelas` $\rightarrow$ `kode_mk`, `nidn_pengampu`, `ruang`, `jadwal_hari_jam` *(Berdasarkan AB-05)*
* **FD6:** (`no_krs`, `kode_kelas`) $\rightarrow$ `nilai_angka`, `nilai_huruf` *(Berdasarkan AB-06)*
* **FD7:** `nilai_angka` $\rightarrow$ `nilai_huruf` *(Atribut Nilai Turunan berdasarkan AB-06)*

---

## 3. Tahapan Normalisasi (1NF, 2NF, 3NF) & Pemeriksaan BCNF

### a. First Normal Form (1NF)
Menghilangkan kelompok berulang (*repeating group*) dengan memastikan setiap atribut bernilai atomik. Kunci primer dibentuk dari kunci komposit (`no_krs`, `kode_kelas`):

> **KRS_1NF** (**`no_krs`**, **`kode_kelas`**, `nim`, `nama_mahasiswa`, `prodi`, `nidn_pa`, `nama_dosen_pa`, `tahun_akademik`, `semester`, `tanggal_krs`, `status_persetujuan`, `kode_mk`, `nama_mk`, `sks`, `semester_paket`, `nidn_pengampu`, `nama_dosen_pengampu`, `ruang`, `jadwal_hari_jam`, `nilai_angka`, `nilai_huruf`, `total_sks`)

---

### b. Second Normal Form (2NF)
Menghilangkan ketergantungan parsial, yaitu memisahkan atribut bukan kunci yang hanya bergantung pada sebagian kunci komposit:

* **`KRS`** (**`no_krs`**, `nim`, `nama_mahasiswa`, `prodi`, `nidn_pa`, `nama_dosen_pa`, `tahun_akademik`, `semester`, `tanggal_krs`, `status_persetujuan`)
* **`DETAIL_KRS`** (**`no_krs`***, **`kode_kelas`***, `nilai_angka`, `nilai_huruf`)
* **`KELAS`** (**`kode_kelas`**, `kode_mk`, `nama_mk`, `sks`, `semester_paket`, `nidn_pengampu`, `nama_dosen_pengampu`, `ruang`, `jadwal_hari_jam`)

---

### c. Third Normal Form (3NF)
Menghilangkan ketergantungan transitif (`no_krs` $\rightarrow$ `nim` $\rightarrow$ `nama_mahasiswa`, `nim` $\rightarrow$ `nidn_pa` $\rightarrow$ `nama_dosen_pa`, dan `kode_kelas` $\rightarrow$ `kode_mk` $\rightarrow$ `nama_mk`) serta membuang atribut nilai turunan (`total_sks`, `nilai_huruf`) dari tabel operasional transaksi:

* **`DOSEN`** (**`id_dosen`**, `nidn`, `nama_dosen`, `no_hp`, `email`, `status_dosen`)
* **`MAHASISWA`** (**`id_mahasiswa`**, `nim`, `nama_mahasiswa`, `prodi`, `no_hp`, `email`, `status_akademik`, `id_dosen_pa`*)
* **`MATA_KULIAH`** (**`id_mk`**, `kode_mk`, `nama_mk`, `sks`, `semester_paket`)
* **`KELAS`** (**`id_kelas`**, `kode_kelas`, `id_mk`*, `id_dosen_pengampu`*, `ruang`, `jadwal_hari_jam`)
* **`KRS`** (**`id_krs`**, `no_krs`, `id_mahasiswa`*, `tahun_akademik`, `semester`, `tanggal_krs`, `status_persetujuan`)
* **`DETAIL_KRS`** (**`id_krs`***, **`id_kelas`***, `nilai_angka`)

---

### d. Hasil Pemeriksaan BCNF (Boyce-Codd Normal Form)
Setiap penentu (*determinant*) dalam skema relasional 3NF proyek SIAKAD merupakan kunci kandidat (*candidate key*):
* Pada tabel **`DOSEN`**, penentu `id_dosen` dan `nidn` keduanya merupakan kunci kandidat.
* Pada tabel **`MAHASISWA`**, penentu `id_mahasiswa` dan `nim` keduanya merupakan kunci kandidat.
* Pada tabel **`MATA_KULIAH`**, penentu `id_mk` dan `kode_mk` keduanya merupakan kunci kandidat.
* Pada tabel **`KELAS`**, penentu `id_kelas` dan `kode_kelas` keduanya merupakan kunci kandidat.
* Pada tabel **`KRS`**, penentu `id_krs` dan `no_krs` keduanya merupakan kunci kandidat.
* Pada tabel **`DETAIL_KRS`**, kunci komposit (`id_krs`, `id_kelas`) menentukan atribut `nilai_angka`.

**Kesimpulan:** Skema relasional proyek SIAKAD telah memenuhi syarat **BCNF** karena seluruh penentu yang ada merupakan kunci kandidat.

---

## 4. Keputusan Penyimpanan Nilai Turunan

| Atribut Turunan | Rumus / Cara Hitung | Keputusan | Alasan Keputusan |
| :--- | :--- | :--- | :--- |
| `subtotal_sks` / `total_sks` | `SUM(sks)` dari mata kuliah yang diambil dalam satu KRS | **Tidak Disimpan** | Nilai total SKS dapat dihitung secara langsung (*on-the-fly*) menggunakan fungsi agregasi `SUM(sks)` dengan menggabungkan tabel `detail_krs`, `kelas`, dan `mata_kuliah`. Keputusan ini diambil untuk menghindari inkonsistensi data jika ada pembatalan atau penambahan mata kuliah. |
| `nilai_huruf` | Konversi nilai angka berdasarkan aturan skala nilai (contoh: $\ge 80 \rightarrow \text{A}$) | **Tidak Disimpan** | Nilai huruf merupakan konversi fungsional langsung dari `nilai_angka` (AB-06). Menyimpannya di tabel operasional memicu redundansi; nilai huruf cukup dikonversi secara otomatis melalui ekspresi `CASE` pada kueri `SELECT` atau View KHS. |
| `ips` / `ipk` | `SUM(bobot * sks) / SUM(sks)` | **Tidak Disimpan** | Indeks Prestasi merupakan perhitungan agregasi kompleks antar-semester. Nilai ini dihitung dinamis saat menerbitkan KHS/KUM (KI-02 & KI-03) agar selalu mencerminkan data nilai terbaru. |

---

## 5. Catatan Perubahan ERD Proyek

Hasil normalisasi 3NF ini memperbarui rancangan ERD konseptual pada Pertemuan 3:
1. Pembentukan entitas asosiatif `DETAIL_KRS` untuk memecah hubungan banyak-ke-banyak (*many-to-many*) antara `KRS` dan `KELAS`.
2. Penerapan kunci pengganti (*surrogate key* `id_*`) sebagai *Primary Key* utama pada seluruh tabel untuk menyelaraskan dengan skema kanonik.
3. Penambahan kunci tamu `id_dosen_pa` pada tabel `MAHASISWA` untuk mencatat Dosen Pembimbing Akademik yang menyetujui KRS (AB-04).