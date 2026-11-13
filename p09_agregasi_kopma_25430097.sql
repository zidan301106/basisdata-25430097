-- =====================================================================
-- Praktikum Basis Data - Modul 9 (Studi Kasus Kopma)
-- Berkas   : p09_agregasi_kopma_25430097.sql
-- Nama     : Muhammad Zidan Ilham
-- NPM      : 25430097
-- Database : kopma_097
-- =====================================================================

USE kopma_097;

-- D.1 Mengaktifkan mode ketat pengelompokan & verifikasi rentang data
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

SELECT COUNT(*) AS nota, MIN(tgl_penjualan) AS awal, MAX(tgl_penjualan) AS akhir 
FROM penjualan;
-- Hasil yang diharapkan: 75 nota, dari 2026-09-02 sampai 2026-10-31.

-- D.2 Total Satu Nota
SELECT p.no_nota_penjualan, SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS jumlah
FROM penjualan p 
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0001'
GROUP BY p.id_penjualan, p.no_nota_penjualan;

-- D.3 (KI-01) Laporan Omzet Harian Minggu Pertama September dengan WITH ROLLUP
SELECT DATE(p.tgl_penjualan) AS tanggal,
       COUNT(DISTINCT p.id_penjualan) AS nota,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-01' AND p.tgl_penjualan < '2026-09-08'
GROUP BY DATE(p.tgl_penjualan) WITH ROLLUP;

-- D.3 (KI-01) Laporan Omzet Bulanan
SELECT DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
       COUNT(DISTINCT p.id_penjualan) AS nota,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m') WITH ROLLUP;
-- Hasil yang diharapkan: 2026-09 = 39 nota (Rp691.000), 2026-10 = 36 nota (Rp507.500).

-- D.4 Menyaring Kelompok dengan HAVING (Kasir > 20 nota)
SELECT pt.kode_petugas, pt.nama_petugas, COUNT(*) AS nota
FROM penjualan p 
JOIN petugas pt ON pt.id_petugas = p.id_petugas
GROUP BY pt.id_petugas, pt.kode_petugas, pt.nama_petugas
HAVING COUNT(*) > 20;

-- D.4 Menyaring Kelompok dengan HAVING (Barang total qty terjual < 10)
SELECT b.kode_barang, b.nama_barang, SUM(d.qty_detail_penjualan) AS total_qty
FROM barang b
JOIN detail_penjualan d ON b.id_barang = d.id_barang
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
HAVING SUM(d.qty_detail_penjualan) < 10;

-- Titik Analisis 3: Rata-rata belanja per nota khusus anggota aktif
SELECT AVG(total_nota) AS rata_rata_belanja_anggota
FROM (
    SELECT p.id_penjualan, SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS total_nota
    FROM penjualan p
    JOIN detail_penjualan d ON p.id_penjualan = d.id_penjualan
    WHERE p.id_anggota IS NOT NULL
    GROUP BY p.id_penjualan
) AS rekap_nota_anggota;

-- E.1 Total nota dengan diskon 5% untuk anggota aktif & kembalian > Rp4.000
SELECT p.no_nota_penjualan,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS subtotal,
       CASE WHEN a.status_anggota = 'aktif' THEN SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95
            ELSE SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) END AS total_akhir,
       p.bayar_penjualan,
       (p.bayar_penjualan - CASE WHEN a.status_anggota = 'aktif' THEN SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95
            ELSE SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) END) AS kembalian
FROM penjualan p
JOIN detail_penjualan d ON p.id_penjualan = d.id_penjualan
LEFT JOIN anggota a ON p.id_anggota = a.id_anggota
GROUP BY p.id_penjualan, p.no_nota_penjualan, p.bayar_penjualan, a.status_anggota
HAVING kembalian > 4000;

-- E.2 Omzet per kategori barang per bulan dengan WITH ROLLUP
SELECT DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
       k.nama_kategori,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON p.id_penjualan = d.id_penjualan
JOIN barang b ON d.id_barang = b.id_barang
JOIN kategori k ON b.id_kategori = k.id_kategori
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m'), k.nama_kategori WITH ROLLUP;