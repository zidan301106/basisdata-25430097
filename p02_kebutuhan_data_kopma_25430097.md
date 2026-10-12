# Dokumen Kebutuhan Data Koperasi Mahasiswa Sejahtera (Kopma)

## 1. Latar Belakang dan Aktivitas Organisasi
Koperasi Mahasiswa Sejahtera (Kopma) bergerak di bidang penjualan alat tulis, makanan ringan, dan minuman di lingkungan kampus. Pembeli terdiri dari anggota dan non-anggota (umum). Aktivitas utama meliputi pendaftaran anggota, pencatatan penjualan kasir, pemesanan dan penerimaan stok barang dari pemasok, serta penyusunan laporan operasional bulanan.

## 2. Aktor dan Proses Bisnis
| Kode Proses | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir | Mahasiswa ingin menjadi anggota |
| PB-02 | Mencatat penjualan | Kasir | Pembeli membayar di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas gudang | Stok di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas gudang | Barang datang bersama faktur |
| PB-05 | Menyusun laporan bulanan | Ketua koperasi | Awal bulan |
| PB-06 | Mengelola data pemasok | Petugas gudang | Ada pemasok baru atau perubahan data |
| PB-07 | Mengelola poin loyalitas | Kasir / Ketua | Anggota menukarkan poin belanja |

## 3. Dokumen Sumber yang Dianalisis
Dokumen sumber utama adalah Nota Penjualan Kopma. Elemen data yang dianalisis:
- Identitas transaksi: Nomor Nota (PJ-2609-0142), Tanggal-Jam
- Relasi Aktor: Kasir (K03 - Rina), Anggota (A-0457 / Budi S.)
- Rincian Barang: Kode/Nama Barang, Qty, Harga saat transaksi
- Nilai Turunan (Dihitung): Subtotal, Diskon Anggota 5%, Total, Bayar, Kembali

## 4. Entitas Kandidat dan Elemen Data
1. **Anggota**: id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota, poin_anggota
2. **Barang**: id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang
3. **Penjualan**: id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan
4. **Detail Penjualan**: id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan
5. **Petugas**: id_petugas, kode_petugas, nama_petugas, peran_petugas
6. **Pemasok**: id_pemasok, nama_pemasok, telepon_pemasok, alamat_pemasok
7. **Pembelian**: id_pembelian, no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian
8. **Detail Pembelian**: id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian

## 5. Aturan Bisnis
- **AB-01**: Setiap nota memiliki nomor unik dan minimal satu baris barang.
- **AB-02**: Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 5%.
- **AB-03**: Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok tersedia.
- **AB-04**: Harga jual yang dipakai pada nota disimpan per baris detail dan tidak berubah meski harga barang kemudian naik.
- **AB-05**: NIM anggota unik; pencarian anggota dapat dilakukan lewat nomor anggota atau NIM.
- **AB-06**: Pesanan pembelian dibuat bila stok kurang dari batas minimum barang tersebut.
- **AB-07**: Setiap kelipatan Rp10.000 belanja anggota bernilai 1 poin; 50 poin dapat ditukar dengan potongan Rp5.000.

## 6. Kebutuhan Informasi
- **KI-01**: Omzet dan jumlah nota per hari dan per bulan.
- **KI-02**: Lima barang terlaris per bulan berdasarkan qty.
- **KI-03**: Barang dengan stok di bawah batas minimum.
- **KI-04**: Sepuluh anggota dengan belanja terbesar per bulan.
- **KI-05**: Rekapitulasi perolehan dan penukaran poin loyalitas anggota.

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian | Detail Pembelian |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| PB-01 Daftar anggota | C | | | | | | |
| PB-02 Catat penjualan | R | R, U | C | C | | | |
| PB-03 Pesan ke pemasok | | R | | | R | C | C |
| PB-04 Terima barang | | U | | | R | U | R |
| PB-05 Laporan bulanan | R | R | R | R | | R | R |
| PB-06 Mengelola pemasok | | | | | C, U, D | | |
| PB-07 Kelola poin | U | | R | R | | | |

## 8. Kamus Data Awal
| Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|
| no_anggota | Nomor anggota koperasi | A-0457 | Unik, format A-4 digit | Ketua |
| nim_anggota | NIM anggota | 25430097 | Unik, 10 digit | Ketua |
| no_hp_anggota | Nomor HP anggota | 08123456789 | Data pribadi, akses terbatas | Ketua |
| no_nota_penjualan | Nomor nota penjualan | PJ-2609-0142 | Unik per nota | Kasir |
| harga_satuan_detail_penjualan | Harga jual saat transaksi | 4000 | Bilangan bulat >= 0 | Kasir |
| stok_barang | Jumlah barang tersedia | 35 | Bilangan bulat >= 0 (AB-03) | Petugas gudang |

## 9. Kebutuhan Non-Fungsional Data
- Perkiraan volume transaksi: ±150 nota per hari.
- Retensi data: Data transaksi disimpan minimal 5 tahun.
- Hak Akses Privasi: Nomor HP anggota bersifat pribadi, hanya dapat diakses oleh Ketua Kopma.

## 10. Isu Kualitas Data yang Diantisipasi
- Penulisan nama anggota atau pemasok yang berbeda ejaan.
- Pencatatan nomor HP yang menggunakan kombinasi konversi (+62 / 08).
- Perubahan harga barang di katalog yang berpotensi merusak riwayat transaksi lama jika harga tidak disalin ke nota.