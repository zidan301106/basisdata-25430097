# Modul 4: Normalisasi dan Skema Relasional

**Nama:** Muhammad Zidan Ilham
**NPM:** 25430097  
**Tema:** Akademik  
**Dosen:**Dedi Irawan, S.Kom., M.T.I.,mbv  

---

## D. Langkah Percobaan (Studi Kasus Kopma)

### D.1 Dari UNF ke 1NF

#### 1. Unnormalized Form (UNF)
Pada bentuk awal (UNF), data spreadsheet lama Koperasi Mahasiswa (Kopma) mencatat seluruh informasi dalam satu tabel tunggal yang mengandung grup berulang (*repeating group*) pada elemen rincian barang[cite: 35, 36]:

> **NOTA_UNF** (`no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, { `kode_barang`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan` }, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)[cite: 36]

#### 2. First Normal Form (1NF)
Bentuk 1NF dicapai dengan menghilangkan grup berulang sehingga setiap sel memuat nilai atomik[cite: 35, 36]. Setiap baris kini mewakili satu jenis barang pada transaksi penjualan, dengan kunci primer berupa kunci komposit (`no_nota_penjualan`, `kode_barang`)[cite: 36]:

> **NOTA_1NF** (**`no_nota_penjualan`**, **`kode_barang`**, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)[cite: 36]

---

### D.2 Menuliskan Dependensi Fungsional (Functional Dependency)

Dependensi fungsional diturunkan secara logis berdasarkan Aturan Bisnis (AB) Kopma[cite: 35, 36]:

* **FD1:** `no_nota_penjualan` $\rightarrow$ `tgl_penjualan`, `kode_petugas`, `no_anggota`, `bayar_penjualan`[cite: 36] *(Sesuai AB-01)*[cite: 20, 36]
* **FD2:** `kode_petugas` $\rightarrow$ `nama_petugas`, `peran_petugas`[cite: 36]
* **FD3:** `no_anggota` $\rightarrow$ `nama_anggota`, `nim_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`[cite: 36] *(Sesuai AB-05)*[cite: 20, 36]
* **FD4:** `kode_barang` $\rightarrow$ `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`[cite: 36]
* **FD5:** (`no_nota_penjualan`, `kode_barang`) $\rightarrow$ `qty_detail_penjualan`, `harga_satuan_detail_penjualan`[cite: 36] *(Sesuai AB-04)*[cite: 20, 36]
* **FD6:** (`qty_detail_penjualan`, `harga_satuan_detail_penjualan`) $\rightarrow$ `subtotal_detail_penjualan`[cite: 36] *(Atribut Nilai Turunan)*[cite: 36]

> **Titik Analisis 1:**  
> FD5 menempatkan `harga_satuan_detail_penjualan` pada kunci komposit (`no_nota_penjualan`, `kode_barang`) untuk mengunci harga barang pada saat transaksi terjadi (AB-04)[cite: 20, 36]. Jika atribut ini dipisahkan atau hanya dibaca dari master `barang`, maka kenaikan harga barang di kemudian hari akan merubah nilai pada transaksi lama, yang mengakibatkan laporan keuangan historis menjadi tidak akurat (anomali ubah)[cite: 35, 36].

---

### D.3 Menuju 2NF dan 3NF

#### 1. Second Normal Form (2NF)
Bentuk 2NF dicapai dengan menghapus ketergantungan parsial (atribut bukan kunci yang hanya bergantung pada sebagian kunci komposit)[cite: 35, 37]:

* **`PENJUALAN`** (**`no_nota_penjualan`**, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `bayar_penjualan`)[cite: 37]
* **`DETAIL_PENJUALAN`** (**`no_nota_penjualan`***, **`kode_barang`***, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`)[cite: 37]
* **`BARANG`** (**`kode_barang`**, `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`)[cite: 37]

#### 2. Third Normal Form (3NF)
Bentuk 3NF dicapai dengan memisahkan ketergantungan transitif (`no_nota_penjualan` $\rightarrow$ `kode_petugas` $\rightarrow$ `nama_petugas` dan `no_nota_penjualan` $\rightarrow$ `no_anggota` $\rightarrow$ `nama_anggota`) serta menghapus kolom nilai turunan (`subtotal`, `jumlah`, `total`) agar terhindar dari potensi data tidak konsisten[cite: 35, 37]:

* **`PETUGAS`** (**`kode_petugas`**, `nama_petugas`, `peran_petugas`)[cite: 37]
* **`ANGGOTA`** (**`no_anggota`**, `nim_anggota`, `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`)[cite: 37]
* **`BARANG`** (**`kode_barang`**, `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`)[cite: 37]
* **`PENJUALAN`** (**`no_nota_penjualan`**, `tgl_penjualan`, `kode_petugas`*, `no_anggota`*, `bayar_penjualan`)[cite: 37]
* **`DETAIL_PENJUALAN`** (**`no_nota_penjualan`***, **`kode_barang`***, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`)[cite: 37]

> **Titik Analisis 2:**  
> Nilai `total` tidak disimpan di tabel operasional transaksi untuk mencegah redundansi dan redundansi data yang tidak konsisten jika item transaksi dikoreksi[cite: 37]. Keputusan berbeda berlaku untuk data arsip historis di mana nilai total boleh disimpan, sebab data arsip bersifat *read-only* (potret sejarah yang tidak akan diubah lagi) untuk mempercepat kinerja kueri pembacaan[cite: 37].

---

### D.4 Membandingkan dengan Skema Kanonik Kopma

Skema hasil normalisasi 3NF disesuaikan dengan standar skema kanonik Kopma yang menggunakan kunci pengganti (*surrogate key* `id_*`) sebagai *primary key*[cite: 37]:

| Nama Tabel | Kunci Primer (PK) | Kunci Unik (UNIQUE) | Kunci Tamu (FK) | Atribut Lain |
| :--- | :--- | :--- | :--- | :--- |
| **`petugas`** | `id_petugas`[cite: 37] | `kode_petugas`[cite: 37] | - | `nama_petugas`, `peran_petugas`[cite: 37] |
| **`anggota`** | `id_anggota`[cite: 37] | `no_anggota`, `nim_anggota`[cite: 37] | - | `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`[cite: 37] |
| **`barang`** | `id_barang`[cite: 38] | `kode_barang`[cite: 38] | - | `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`[cite: 37, 38] |
| **`pemasok`** | `id_pemasok`[cite: 38] | - | - | `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`[cite: 38] |
| **`penjualan`** | `id_penjualan`[cite: 38] | `no_nota_penjualan`[cite: 38] | `id_petugas`, `id_anggota` *(opsional)*[cite: 38] | `tgl_penjualan`, `bayar_penjualan`[cite: 37, 38] |
| **`detail_penjualan`** | (`id_penjualan`, `id_barang`)[cite: 38] | - | `id_penjualan`, `id_barang`[cite: 38] | `qty_detail_penjualan`, `harga_satuan_detail_penjualan`[cite: 37, 38] |
| **`pembelian`** | `id_pembelian`[cite: 38] | - | `id_pemasok`[cite: 38] | `no_faktur_pembelian`, `tgl_pembelian`, `status_pembelian`[cite: 37, 38] |
| **`detail_pembelian`** | (`id_pembelian`, `id_barang`)[cite: 38] | - | `id_pembelian`, `id_barang`[cite: 38] | `qty_detail_pembelian`, `harga_beli_detail_pembelian`[cite: 38] |

> **Titik Analisis 3:**  
> Kolom `pemasok_brg` pada spreadsheet lama dipisahkan dari tabel `barang` dan dihubungkan lewat transaksi pengadaan (`pembelian` & `detail_pembelian`)[cite: 38]. Keuntungannya adalah Kopma dapat membeli satu jenis barang dari beberapa pemasok yang berbeda tanpa perlu menduplikasi data barang atau mengalami anomali[cite: 38].