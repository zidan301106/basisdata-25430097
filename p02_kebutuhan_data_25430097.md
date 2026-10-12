# Dokumen Kebutuhan Data - Sistem Informasi Akademik (SIAKAD)
**Penyusun:** Muhammad Zidan Ilham  
**NPM:** 25430097  

## 1. Latar Belakang
Sistem Informasi Akademik (SIAKAD) Universitas Muhammadiyah Metro merupakan layanan terpadu pengelolaan data perkuliahan, data mahasiswa, dosen, rencana studi (KRS), hasil belajar (KHS), hingga rekapitulasi nilai akademik.

## 2. Aktor dan Proses Bisnis
| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan mahasiswa baru | Petugas BAAK | Penerimaan mahasiswa baru |
| PB-02 | Mengelola data mata kuliah & kelas | Petugas BAAK | Penjadwalan awal semester |
| PB-03 | Pengisian Kartu Rencana Studi (KRS) | Mahasiswa | Masa perwalian semester |
| PB-04 | Penginputan nilai akhir mata kuliah | Dosen | Masa evaluasi akhir semester |
| PB-05 | Mengelola data dosen & pembimbing | Petugas BAAK | Pengangkatan / pembaruan dosen |
| PB-06 | Penerbitan KHS & Rekap IPK | Mahasiswa / BAAK | Cetak hasil studi akhir semester |

## 3. Dokumen Sumber
1. Formulir Pendaftaran Mahasiswa Baru
2. Katalog Kurikulum & Data Mata Kuliah
3. Formulir Kartu Rencana Studi (KRS)
4. Lembar Pengesahan Perwalian Dosen PA
5. Draff Nilai Akhir Perkuliahan

**Dokumen Sumber Utama (Formulir KRS):**  
Berisi NIM, Nama Mahasiswa, Program Studi, Dosen Pembimbing Akademik, Tahun Akademik, Semester, Kode MK, Nama MK, SKS, Kelas, Jadwal Perkuliahan, serta Total SKS.

## 4. Entitas Kandidat dan Elemen Data
| Entitas | Elemen Data |
|---|---|
| **Mahasiswa** | nim, nama_mahasiswa, prodi, no_hp, email, status_akademik |
| **Dosen** | nidn, nama_dosen, no_hp, email, status_dosen |
| **Mata_Kuliah** | kode_mk, nama_mk, sks, semester_paket |
| **Kelas** | kode_kelas, kode_mk, nidn_dosen, ruang, jadwal_hari_jam |
| **KRS** | no_krs, nim, tahun_akademik, semester, tanggal_krs, status_persetujuan |
| **Detail_KRS** | no_krs, kode_kelas, nilai_angka, nilai_huruf |

## 5. Aturan Bisnis
- **AB-01**: NIM mahasiswa bersifat unik (8 digit angka).
- **AB-02**: NIDN dosen bersifat unik (10 digit angka).
- **AB-03**: Pengisian KRS disesuaikan dengan aturan parameter $P$, di mana maksimal mata kuliah yang dapat diambil adalah 10 kelas/MK per semester.
- **AB-04**: Setiap mahasiswa wajib mendapatkan persetujuan (pembimbingan) dari Dosen PA untuk memvalidasi KRS.
- **AB-05**: Mahasiswa tidak diizinkan memilih dua kelas perkuliahan yang memiliki jadwal hari dan jam yang sama (bentrok).
- **AB-06**: Nilai huruf (A, B, C, D, E) dikonversi secara otomatis berdasarkan masukan nilai angka (0 - 100).

## 6. Kebutuhan Informasi
| Kode | Kebutuhan Informasi |
|---|---|
| **KI-01** | Lembar Kartu Rencana Studi (KRS) per mahasiswa per semester |
| **KI-02** | Kartu Hasil Studi (KHS) beserta nilai Indeks Prestasi Semester (IPS) |
| **KI-03** | Rekapitulasi Indeks Prestasi Kumulatif (IPK) seluruh mahasiswa per prodi |
| **KI-04** | Daftar mahasiswa bimbingan aktif per Dosen Pembimbing Akademik |
| **KI-05** | Rekapitulasi peserta dan presensi perkuliahan per kelas |

## 7. Matriks CRUD
| Proses | Mahasiswa | Dosen | Mata Kuliah | Kelas | KRS | Detail KRS |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **PB-01** | C | | | | | |
| **PB-02** | | R | C, U | C, U, D | | |
| **PB-03** | R | R | R | R | C | C |
| **PB-04** | R | R | | R | R | U |
| **PB-05** | | C, R, U | | | | |
| **PB-06** | R | R | R | R | R | R |

## 8. Kamus Data Awal
1. `nim`: Nomor Pokok Mahasiswa | Contoh: `25430097` | Aturan: Unik, 8 digit | PJ: BAAK
2. `nama_mahasiswa`: Nama Mahasiswa | Contoh: `Muhammad Zidan Ilham` | Teks | PJ: BAAK
3. `prodi`: Program Studi | Contoh: `Ilmu Komputer` | Teks | PJ: BAAK
4. `no_hp`: Nomor Handphone Mahasiswa | Contoh: `081234567890` | Data Pribadi (PDP) | PJ: BAAK
5. `nidn`: Nomor Induk Dosen Nasional | Contoh: `0230118001` | Unik, 10 digit | PJ: BAAK
6. `kode_mk`: Kode Mata Kuliah | Contoh: `INF-201` | Unik per MK | PJ: Kaprodi
7. `sks`: Jumlah Bobot SKS | Contoh: `3` | Integer (1-6) | PJ: Kaprodi
8. `nilai_angka`: Nilai Akhir Angka | Contoh: `88.5` | Float (0 - 100) | PJ: Dosen Pengampu
9. `nilai_huruf`: Konversi Nilai Huruf | Contoh: `A` | ENUM(A, B, C, D, E) | PJ: Dosen Pengampu

## 9. Kebutuhan Non-Fungsional Data
**Perhitungan Parameter $P$ berbasis NPM (NPM: 25430097):**
```text
NPM = 25430097
2 Digit Akhir = 97
P = (97 mod 9) + 1 = 7 + 1 = 8