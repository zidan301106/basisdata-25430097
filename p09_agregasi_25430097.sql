-- =====================================================================
-- Praktikum Basis Data - Modul 9 (Fungsi Agregat, GROUP BY, HAVING, ROLLUP)
-- Berkas   : p09_agregasi_25430097.sql
-- Nama     : Muhammad Zidan Ilham
-- NPM      : 25430097
-- Database : siakad_097
-- =====================================================================

USE siakad_097;

-- Mengaktifkan mode ketat pengelompokan sesuai standar Modul 9
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- ---------------------------------------------------------------------
-- KI-01: Rekapitulasi Jumlah Mahasiswa Aktif per Program Studi
-- Menggunakan: COUNT(*), COUNT(kolom), GROUP BY
-- ---------------------------------------------------------------------
SELECT 
    prodi AS program_studi,
    COUNT(*) AS total_mahasiswa,
    COUNT(no_hp) AS jumlah_punya_hp
FROM mahasiswa
WHERE status_akademik = 'aktif'
GROUP BY prodi
ORDER BY total_mahasiswa DESC;

-- ---------------------------------------------------------------------
-- KI-02: Laporan Statistik Nilai Angka (Min, Maks, Rata-rata) per Mata Kuliah
-- Menggunakan: COUNT, MIN, MAX, AVG, IFNULL, JOIN, GROUP BY
-- ---------------------------------------------------------------------
SELECT 
    mk.kode_mk,
    mk.nama_mk,
    COUNT(dk.id_krs) AS jumlah_peserta,
    MIN(dk.nilai_angka) AS nilai_terendah,
    MAX(dk.nilai_angka) AS nilai_tertinggi,
    ROUND(AVG(IFNULL(dk.nilai_angka, 0)), 2) AS rata_rata_nilai
FROM detail_krs dk
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
GROUP BY mk.id_mk, mk.kode_mk, mk.nama_mk
ORDER BY rata_rata_nilai DESC;

-- ---------------------------------------------------------------------
-- KI-03: Daftar Mahasiswa dengan Rata-rata Nilai di Atas 85 (Saring Kelompok)
-- Menggunakan: COUNT, SUM, AVG, GROUP BY, HAVING
-- ---------------------------------------------------------------------
SELECT 
    m.nim,
    m.nama_mahasiswa,
    m.prodi,
    COUNT(dk.id_kelas) AS total_kelas_diambil,
    SUM(mk.sks) AS total_sks,
    ROUND(AVG(dk.nilai_angka), 2) AS rata_rata_nilai
FROM mahasiswa m
JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
GROUP BY m.id_mahasiswa, m.nim, m.nama_mahasiswa, m.prodi
HAVING AVG(dk.nilai_angka) > 85.00
ORDER BY rata_rata_nilai DESC;

-- ---------------------------------------------------------------------
-- KI-04: Rekapitulasi Beban SKS & Jumlah Kelas yang Diampu Setiap Dosen
-- Menggunakan: COUNT(DISTINCT ...), SUM, GROUP BY, HAVING
-- ---------------------------------------------------------------------
SELECT 
    d.nidn,
    d.nama_dosen,
    COUNT(DISTINCT kl.id_kelas) AS jumlah_kelas_diampu,
    SUM(mk.sks) AS total_sks_ajar
FROM dosen d
JOIN kelas kl ON d.id_dosen = kl.id_dosen
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
GROUP BY d.id_dosen, d.nidn, d.nama_dosen
HAVING COUNT(DISTINCT kl.id_kelas) >= 1
ORDER BY total_sks_ajar DESC;

-- ---------------------------------------------------------------------
-- KI-05: Laporan Ringkasan Bertingkat Pengajuan KRS per Tanggal & Status
-- Menggunakan: COUNT(DISTINCT ...), GROUP BY ... WITH ROLLUP
-- ---------------------------------------------------------------------
SELECT 
    k.tanggal_krs,
    k.status_persetujuan,
    COUNT(DISTINCT k.id_krs) AS jumlah_dokumen_krs,
    COUNT(dk.id_kelas) AS total_item_kelas_diambil
FROM krs k
LEFT JOIN detail_krs dk ON k.id_krs = dk.id_krs
GROUP BY k.tanggal_krs, k.status_persetujuan WITH ROLLUP;