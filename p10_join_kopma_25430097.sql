-- =====================================================================
-- Praktikum Basis Data - Modul 10 (Studi Kasus Kopma)
-- Berkas   : p10_join_kopma_25430097.sql
-- Nama     : Muhammad Zidan Ilham
-- NPM      : 25430097
-- Database : kopma_097
-- =====================================================================

USE kopma_097;

SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- D.1 (KI-02) INNER JOIN: 5 Barang Terlaris Bulan Oktober 2026
-- Jalur ERD: detail_penjualan -> barang, detail_penjualan -> penjualan
SELECT b.kode_barang, b.nama_barang, SUM(d.qty_detail_penjualan) AS terjual
FROM detail_penjualan d
JOIN barang b ON b.id_barang = d.id_barang
JOIN penjualan p ON p.id_penjualan = d.id_penjualan
WHERE p.tgl_penjualan >= '2026-10-01' AND p.tgl_penjualan < '2026-11-01'
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
ORDER BY terjual DESC
LIMIT 5;

-- D.2 (KI-04) JOIN Tiga Tabel: Anggota dengan Belanja Terbesar
-- Jalur ERD: anggota -> penjualan -> detail_penjualan
SELECT a.no_anggota, a.nama_anggota,
       COUNT(DISTINCT p.id_penjualan) AS nota,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS belanja
FROM anggota a
JOIN penjualan p ON p.id_anggota = a.id_anggota
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY a.id_anggota, a.no_anggota, a.nama_anggota
ORDER BY belanja DESC
LIMIT 5;

-- D.3 LEFT JOIN: Barang yang Belum Pernah Terjual (Data Tanpa Pasangan)
-- Jalur ERD: barang (kiri) -> detail_penjualan (kanan)
SELECT b.kode_barang, b.nama_barang, COUNT(d.id_barang) AS baris_terjual
FROM barang b
LEFT JOIN detail_penjualan d ON d.id_barang = b.id_barang
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
HAVING COUNT(d.id_barang) = 0;

-- D.4 Membuktikan Perkalian Kartesius vs JOIN dengan Syarat ON
SELECT COUNT(*) AS jumlah_kartesius FROM penjualan, detail_penjualan;
SELECT COUNT(*) AS jumlah_join_benar FROM penjualan p JOIN detail_penjualan d ON p.id_penjualan = d.id_penjualan;

-- E.1 Daftar Nota Oktober beserta Nama Kasir dan Nama Anggota (Non-Anggota = 'Umum')
SELECT p.no_nota_penjualan,
       p.tgl_penjualan,
       pt.nama_petugas AS nama_kasir,
       COALESCE(a.nama_anggota, 'Umum') AS nama_pembeli
FROM penjualan p
JOIN petugas pt ON p.id_petugas = pt.id_petugas
LEFT JOIN anggota a ON p.id_anggota = a.id_anggota
WHERE p.tgl_penjualan >= '2026-10-01' AND p.tgl_penjualan < '2026-11-01'
ORDER BY p.tgl_penjualan ASC;

-- E.2 Bukti AB-04: Perubahan Harga Pulpen Gel 0.5 Sebelum dan Sesudah 15 Oktober
SELECT p.no_nota_penjualan,
       p.tgl_penjualan,
       b.nama_barang,
       d.harga_satuan_detail_penjualan AS harga_saat_transaksi,
       b.harga_jual_barang AS harga_katalog_saat_ini
FROM penjualan p
JOIN detail_penjualan d ON p.id_penjualan = d.id_penjualan
JOIN barang b ON d.id_barang = b.id_barang
WHERE b.nama_barang LIKE '%Pulpen Gel 0.5%'
ORDER BY p.tgl_penjualan ASC;