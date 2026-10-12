# Dokumen Kebutuhan Data - KOPMA
**Pengembang System:** Muhammad Zidan Ilham  
**NPM:** 25430097  

## 1. Latar Belakang dan Aktivitas Organisasi
Koperasi Mahasiswa (Kopma) Universitas Muhammadiyah Metro adalah organisasi mahasiswa yang menyediakan layanan penjualan barang konsumsi, alat tulis kantor, dan perlengkapan perkuliahan bagi anggota maupun masyarakat umum. Pembeli terdiri dari anggota terdaftar dan pelanggan non-anggota. Mahasiswa yang ingin mendaftar sebagai anggota wajib mengisi formulir dengan menyertakan nama lengkap, NIM, program studi, serta nomor WhatsApp aktif. Setelah terdaftar, anggota memperoleh nomor anggota unik dengan format `A-XXXX` dan berhak mendapatkan diskon khusus anggota sebesar 5% pada setiap transaksi.

Aktivitas utama Kopma meliputi pendaftaran dan pengelolaan data anggota, pengelolaan inventaris barang dan pemasok, penerimaan barang masuk, pemeriksaan stok berkala, serta pencatatan transaksi penjualan kasir. Seluruh data transaksi ini dikelola secara terpusat agar menghasilkan laporan operasional harian dan bulanan yang akurat bagi pengurus.

## 2. Aktor dan Proses Bisnis
Aktor yang terlibat dalam kegiatan operasional Kopma antara lain: Pengurus/Ketua, Kasir, Petugas Gudang, serta Anggota/Pelanggan.

| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftar anggota baru | Kasir / Admin | Mahasiswa mengajukan pendaftaran anggota |
| PB-02 | Mencatat transaksi penjualan | Kasir | Pelanggan melakukan pembayaran di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas Gudang | Stok barang mencapai/di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas Gudang | Pengiriman barang tiba bersama nota/faktur |
| PB-05 | Menyusun laporan bulanan | Ketua Kopma | Periode rekapitulasi akhir bulan |
| PB-06 | Mengelola data pemasok | Petugas Gudang | Penambahan pemasok baru atau pembaruan kontak |

## 3. Dokumen Sumber yang Dianalisis
Dokumen sumber yang digunakan untuk memahami kebutuhan data Kopma meliputi:
1. Formulir Pendaftaran Anggota Kopma
2. Struk / Nota Penjualan Kasir
3. Dokumen Penerimaan Barang (Surat Jalan/Faktur)
4. Buku Catatan Stok Gudang
5. Master Data Pemasok
6. Laporan Rekapitulasi Penjualan Harian & Bulanan

## 4. Entitas Kandidat dan Elemen Data

| Entitas Kandidat | Elemen Data Utama | Sumber Dokumen |
|---|---|---|
| **Anggota** | nomor_anggota, NIM, nama_lengkap, program_studi, no_whatsapp, status_aktif, tanggal_daftar | Formulir Pendaftaran |
| **Barang** | kode_barang, nama_barang, kategori, harga_jual, stok_tersedia, stok_minimum | Katalog Barang & Gudang |
| **Penjualan** | no_nota, tanggal_jam, kasir_penanggungjawab, anggota_id (opsional), total_bayar, metode_pembayaran | Nota Penjualan |
| **Detail Penjualan** | no_nota, kode_barang, jumlah_qty, harga_satuan_transaksi, subtotal | Nota Penjualan |
| **Petugas** | kode_petugas, nama_petugas, peran (Kasir/Gudang/Ketua), nomor_kontak | Data Internal Kepegawaian |
| **Pemasok** | kode_pemasok, nama_pemasok, no_telepon, alamat_pemasok | Faktur Pembelian |
| **Pembelian** | no_faktur, tanggal_pembelian, kode_pemasok, total_pembelian, status_pembayaran | Faktur Pembelian |
| **Detail Pembelian** | no_faktur, kode_barang, jumlah_diterima, harga_beli_satuan | Faktur Pembelian |

## 5. Aturan Bisnis
- **AB-01**: Setiap nota penjualan memiliki nomor transaksi unik dan minimal mencatat satu jenis barang.
- **AB-02**: Transaksi penjualan dapat dilakukan oleh pembeli umum (non-anggota); diskon 5% hanya berlaku untuk anggota dengan status aktif.
- **AB-03**: Stok barang tidak boleh bernilai negatif; sistem secara otomatis menolak transaksi jika jumlah beli melebihi stok yang ada.
- **AB-04**: Harga jual barang yang dicatat pada detail penjualan adalah harga pada saat transaksi terjadi dan tidak berubah meskipun harga master barang mengalami penyesuaian di masa depan.
- **AB-05**: NIM anggota bersifat unik; pencarian data anggota dapat dilakukan menggunakan nomor anggota maupun NIM.
- **AB-06**: Permintaan pembelian barang ke pemasok diterbitkan otomatis jika stok berada di bawah nilai batas minimum (`stok_minimum`).

## 6. Kebutuhan Informasi
| Kode | Kebutuhan Informasi | Data yang Diperlukan |
|---|---|---|
| **KI-01** | Rekapitulasi omzet dan jumlah nota per periode (harian/bulanan) | Penjualan, Detail Penjualan |
| **KI-02** | Daftar 10 produk terlaris (*best seller*) berdasarkan kuantitas terjual | Detail Penjualan, Barang |
| **KI-03** | Laporan peringatan stok kritis (di bawah batas minimum) | Barang, Pemasok |
| **KI-04** | Daftar anggota aktif dengan akumulasi transaksi terbesar | Penjualan, Anggota |

## 7. Matriks CRUD

Keterangan:
- **C** = Create (Membuat Data)
- **R** = Read (Membaca Data)
- **U** = Update (Mengubah Data)
- **D** = Delete (Menghapus Data)

| Proses Bisnis | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **PB-01** Mendaftar anggota | C | | | | | |
| **PB-02** Mencatat penjualan | R | R, U | C | C | | |
| **PB-03** Memesan barang | | R | | | R | C |
| **PB-04** Menerima barang | | U | | | R | U |
| **PB-05** Menyusun laporan | R | R | R | R | | R |
| **PB-06** Mengelola pemasok | | | | | C, R, U, D | |

## 8. Kamus Data Awal
| Elemen Data | Arti / Deskripsi | Contoh Data | Aturan Validasi | Penanggung Jawab |
|---|---|---|---|---|
| `no_anggota` | Nomor identitas anggota Kopma | `A-2501` | Unik, Format `A-XXXX` | Kasir / Admin |
| `nim_anggota` | Nomor Pokok Mahasiswa | `25430097` | Unik, 8 digit angka | Kasir / Admin |
| `nama_lengkap` | Nama lengkap mahasiswa | `Muhammad Zidan Ilham` | Teks, wajib diisi | Kasir / Admin |
| `no_whatsapp` | Nomor WhatsApp anggota | `081234567890` | Data pribadi (PDP) | Kasir / Admin |
| `no_nota` | Nomor bukti transaksi kasir | `PJ-202610-01` | Unik per transaksi | Kasir |
| `harga_satuan` | Harga jual produk saat transaksi | `5000` | Angka non-negatif | Kasir |
| `stok_tersedia` | Jumlah fisik barang di gudang | `45` | Angka >= 0 (AB-03) | Petugas Gudang |

## 9. Kebutuhan Non-Fungsional Data
1. **Perkiraan Volume Transaksi**: Sistem mampu menangani rata-rata transaksi harian hingga ±180 nota per hari.
2. **Retensi Data**: Data transaksi keuangan dan penjualan disimpan minimal selama 5 (lima) tahun untuk keperluan audit.
3. **Privasi Data Pribadi**: Nomor WhatsApp dan NIM anggota merupakan data sensitif yang hanya dapat diakses oleh Pengurus/Ketua Kopma.
4. **Ketersediaan Stok**: Pengelolaan stok dilakukan secara *real-time* untuk menghindari *overselling*.

## 10. Isu Kualitas Data yang Diantisipasi
1. **Harga Historis Transaksi**: Harga barang dapat berubah sewaktu-waktu. Oleh karena itu, harga jual disalin langsung ke tabel detail penjualan agar laporan penjualan masa lalu tetap konsisten.
2. **Pengendalian Stok Negatif**: Pencegahan kesalahan pencatatan kasir jika jumlah barang keluar melebihi jumlah stok fisik yang tercatat.
3. **Kemudahan Identifikasi Anggota**: Mahasiswa sering kali lupa membawa kartu anggota, sehingga sistem mendukung pencarian serbaguna via NIM maupun Nama.
4. **Integritas Data Pemasok**: Memastikan setiap transaksi pembelian barang tercatat dengan pemasok yang terverifikasi dalam sistem.