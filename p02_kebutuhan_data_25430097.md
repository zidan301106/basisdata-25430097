# Dokumen Kebutuhan Data Sistem Informasi Akademik Universitas (SIAKAD)

## 1. Latar Belakang dan Aktivitas Organisasi
Sistem Informasi Akademik (SIAKAD Universitas Muhammadiyah Metro) mengelola aktivitas akademik perguruan tinggi. Aktivitas utama meliputi pendaftaran mahasiswa baru, pembukaan kelas perkuliahan, pengisian Kartu Rencana Studi (KRS) oleh mahasiswa, penginputan nilai semester oleh dosen, dan penerbitan Kartu Hasil Studi (KHS) serta IPK.

## 2. Aktor dan Proses Bisnis
| Kode Proses | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan mahasiswa baru | Staf BAAK | Penerimaan mahasiswa baru |
| PB-02 | Mengelola matakuliah & kelas | Staf BAAK | Penjadwalan awal semester |
| PB-03 | Pengisian KRS | Mahasiswa | Masa perwalian/KRS |
| PB-04 | Menginput nilai perkuliahan | Dosen | Akhir semester |
| PB-05 | Mengelola data dosen | Staf BAAK | Pengangkatan dosen baru |

## 3. Dokumen Sumber yang Dianalisis
Dokumen sumber utama adalah Formulir Kartu Rencana Studi (KRS).
- Identitas Mahasiswa: NIM (25430097), Nama (Muhammad Zidan Ilham), Program Studi (Ilmu Komputer)
- Identitas Semester: Tahun Akademik (2026/2027 Ganjil), Dosen Pembimbing Akademik
- Daftar Matakuliah yang Diambil: Kode MK, Nama MK, SKS, Kelas, Jadwal
- Elemen Turunan: Total SKS yang diambil.

## 4. Entitas Kandidat dan Elemen Data
1. **Mahasiswa**: id_mahasiswa, nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, no_hp_mahasiswa, status_mahasiswa
2. **Dosen**: id_dosen, nidn_dosen, nama_dosen, no_hp_dosen
3. **Mata_Kuliah**: id_mk, kode_mk, nama_mk, sks_mk, semester_mk
4. **Kelas**: id_kelas, id_mk, id_dosen, nama_kelas, ruang_kelas, hari_jam_kelas
5. **KRS**: id_krs, no_krs, id_mahasiswa, ta_krs, semester_krs, tgl_krs
6. **Detail_KRS**: id_krs, id_kelas, nilai_angka_detail_krs, nilai_huruf_detail_krs

## 5. Aturan Bisnis
- **AB-01**: NIM mahasiswa bersifat unik (10 digit).
- **AB-02**: NIDN dosen bersifat unik (10 digit).
- **AB-03**: Satu kelas matakuliah diampu oleh tepat satu dosen utama.
- **AB-04**: Mahasiswa hanya dapat mengambil matakuliah pada kelas yang dibuka di semester berjalan.
- **AB-05**: Maksimal total SKS yang dapat diambil mahasiswa dalam satu KRS disesuaikan dengan aturan parameter P (maksimal 10 item kelas/MK per semester).
- **AB-06**: Nilai huruf dikonversi secara otomatis dari nilai angka (A, B, C, D, E).
- **AB-07**: Pengisian KRS wajib disetujui oleh Dosen Pembimbing Akademik.
- **AB-08**: Mahasiswa tidak dapat mengambil dua kelas dengan jadwal hari dan jam yang bentrok.

## 6. Kebutuhan Informasi
- **KI-01**: Kartu Rencana Studi (KRS) per mahasiswa per semester.
- **KI-02**: Kartu Hasil Studi (KHS) dan Indeks Prestasi Semester (IPS).
- **KI-03**: Daftar hadir perkuliahan dan rekap nilai per kelas.
- **KI-04**: Rekapitulasi Indeks Prestasi Kumulatif (IPK) seluruh mahasiswa per prodi.
- **KI-05**: Daftar mahasiswa bimbingan per dosen pembimbing akademik.

## 7. Matriks CRUD
| Proses Bisnis | Mahasiswa | Dosen | Mata_Kuliah | Kelas | KRS | Detail_KRS |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| PB-01 Daftar mahasiswa | C | | | | | |
| PB-02 Mengelola kelas | | R | C, U | C, U, D | | |
| PB-03 Pengisian KRS | R | R | R | R | C | C |
| PB-04 Input nilai | R | R | | R | R | U |
| PB-05 Mengelola dosen | | C, U, D | | | | |

## 8. Kamus Data Awal
1. **nim_mahasiswa**: NIM Mahasiswa | Contoh: 25430097 | Aturan: Unik, 10 digit | Penanggung Jawab: BAAK
2. **nama_mahasiswa**: Nama Mahasiswa | Contoh: Muhammad Zidan Ilham | Aturan: Wajib diisi | Penanggung Jawab: BAAK
3. **prodi_mahasiswa**: Program Studi | Contoh: Ilmu Komputer | Aturan: Sesuai daftar prodi | Penanggung Jawab: BAAK
4. **no_hp_mahasiswa**: Nomor Telepon | Contoh: 081234567890 | Aturan: Data pribadi (PDP) | Penanggung Jawab: BAAK
5. **status_mahasiswa**: Status Keaktifan | Contoh: Aktif | Aturan: ENUM(aktif, cuti, lulus) | Penanggung Jawab: BAAK
6. **nidn_dosen**: NIDN Dosen | Contoh: 0230118001 | Aturan: Unik, 10 digit | Penanggung Jawab: BAAK
7. **nama_dosen**: Nama Dosen | Contoh: Dedi Irawan, M.T.I | Aturan: Wajib diisi | Penanggung Jawab: BAAK
8. **no_hp_dosen**: Nomor HP Dosen | Contoh: 081234567891 | Aturan: Data pribadi (PDP) | Penanggung Jawab: BAAK
9. **kode_mk**: Kode Matakuliah | Contoh: INF301 | Aturan: Unik per MK | Penanggung Jawab: Kaprodi
10. **nama_mk**: Nama Matakuliah | Contoh: Basis Data | Aturan: Wajib diisi | Penanggung Jawab: Kaprodi
11. **sks_mk**: Bobot SKS | Contoh: 3 | Aturan: Integer 1-6 | Penanggung Jawab: Kaprodi
12. **semester_mk**: Semester MK | Contoh: 3 | Aturan: Integer 1-8 | Penanggung Jawab: Kaprodi
13. **nama_kelas**: Nama Kelas | Contoh: Kelas A | Aturan: Wajib diisi | Penanggung Jawab: BAAK
14. **ruang_kelas**: Ruang Kuliah | Contoh: Lab Komputer 2 | Aturan: Wajib diisi | Penanggung Jawab: BAAK
15. **hari_jam_kelas**: Jadwal Kuliah | Contoh: Senin 08:00 | Aturan: Wajib diisi | Penanggung Jawab: BAAK
16. **no_krs**: Nomor Transaksi KRS | Contoh: KRS-20261-25430097 | Aturan: Unik | Penanggung Jawab: BAAK
17. **ta_krs**: Tahun Akademik | Contoh: 2026/2027 | Aturan: Format YYYY/YYYY | Penanggung Jawab: BAAK
18. **semester_krs**: Semester Tempuh | Contoh: Ganjil | Aturan: ENUM(Ganjil, Genap) | Penanggung Jawab: BAAK
19. **nilai_angka_detail_krs**: Nilai Angka | Contoh: 85.5 | Aturan: Float 0 - 100 | Penanggung Jawab: Dosen
20. **nilai_huruf_detail_krs**: Nilai Huruf | Contoh: A | Aturan: ENUM(A, B, C, D, E) | Penanggung Jawab: Dosen

## 9. Kebutuhan Non-Fungsional Data & Parameter P
- **Perhitungan Parameter P berbasis NIM (NIM: 25430097)**:
  - 2 digit akhir NIM = 97
  - $P = (97 \bmod 9) + 1 = 7 + 1 = \mathbf{8}$
  - Batas maksimal item kelas per KRS ($P + 2$) = **10 kelas/MK**.
  - Persentase bobot/denda ($P$) = **8%**.
  - Perkiraan volume transaksi harian ($40 + 5 \times 8$) = **80 transaksi/hari**.
- **Retensi Data**: Riwayat nilai dan KRS mahasiswa disimpan permanen.
- **Privasi & Keamanan**: Nomor HP mahasiswa dan dosen merupakan data pribadi, hanya dapat diakses oleh BAAK dan Ketua Program Studi.

## 10. Isu Kualitas Data yang Diantisipasi
- Penulisan nama matakuliah yang tidak seragam antar semester.
- Input nilai angka di luar rentang 0-100.
- Mahasiswa mengambil dua kelas pada jam dan hari yang sama (jadwal bentrok).