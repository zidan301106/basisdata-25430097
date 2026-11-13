-- ===================================================
-- PRAKTIKUM BASIS DATA - MODUL 7 (ADVANCED QUERY / DQL)
-- Nama : Muhammad Zidan Ilham
-- NPM  : 25430097
-- File : p07_queries_25430097.sql
-- Database: siakad_097
-- Parameter P = (97 mod 9) + 1 = 8
-- ===================================================

USE siakad_097;

-- ---------------------------------------------------
-- 1. KUERI AGREGASI & GROUP BY (COUNT, AVG, SUM)
-- ---------------------------------------------------

-- 1.1 Menghitung total SKS yang diambil oleh setiap mahasiswa dalam KRS
SELECT 
    m.nim, 
    m.nama_mahasiswa, 
    COUNT(dk.id_kelas) AS total_matakuliah,
    SUM(mk.sks) AS total_sks
FROM mahasiswa m
JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
GROUP BY m.id_mahasiswa, m.nim, m.nama_mahasiswa;

-- 1.2 Menghitung rata-rata nilai angka mahasiswa berdasarkan KRS
SELECT 
    m.nim, 
    m.nama_mahasiswa, 
    ROUND(AVG(dk.nilai_angka), 2) AS rata_rata_nilai
FROM mahasiswa m
JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
GROUP BY m.id_mahasiswa, m.nim, m.nama_mahasiswa;

-- 1.3 Menampilkan mata kuliah yang memiliki minimal P (8) peserta transaksi
SELECT 
    mk.kode_mk, 
    mk.nama_mk, 
    COUNT(dk.id_krs) AS jumlah_peserta
FROM mata_kuliah mk
JOIN kelas kl ON mk.id_mk = kl.id_mk
JOIN detail_krs dk ON kl.id_kelas = dk.id_kelas
GROUP BY mk.id_mk, mk.kode_mk, mk.nama_mk
HAVING jumlah_peserta >= 8;


-- ---------------------------------------------------
-- 2. KUERI ADVANCED JOIN (INNER & LEFT JOIN)
-- ---------------------------------------------------

-- 2.1 INNER JOIN: Menampilkan detail KRS lengkap mahasiswa
SELECT 
    m.nim,
    m.nama_mahasiswa,
    k.no_krs,
    mk.nama_mk,
    kl.kode_kelas,
    d.nama_dosen,
    dk.nilai_angka,
    dk.nilai_huruf
FROM detail_krs dk
INNER JOIN krs k ON dk.id_krs = k.id_krs
INNER JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
INNER JOIN kelas kl ON dk.id_kelas = kl.id_kelas
INNER JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
INNER JOIN dosen d ON kl.id_dosen = d.id_dosen;

-- 2.2 LEFT JOIN: Menampilkan dosen beserta kelas yang diampu (termasuk dosen yang belum mengampu kelas)
SELECT 
    d.nidn, 
    d.nama_dosen, 
    kl.kode_kelas, 
    kl.ruang
FROM dosen d
LEFT JOIN kelas kl ON d.id_dosen = kl.id_dosen;


-- ---------------------------------------------------
-- 3. KUERI SUBQUERY (NESTED QUERY)
-- ---------------------------------------------------

-- 3.1 SUBQUERY di WHERE: Menampilkan mahasiswa yang nilai angkanya di atas rata-rata keseluruhan
SELECT 
    m.nim, 
    m.nama_mahasiswa, 
    mk.nama_mk, 
    dk.nilai_angka
FROM detail_krs dk
JOIN krs k ON dk.id_krs = k.id_krs
JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
WHERE dk.nilai_angka > (SELECT AVG(nilai_angka) FROM detail_krs);

-- 3.2 SUBQUERY dengan IN: Menampilkan mahasiswa yang mengambil mata kuliah Basis Data
SELECT 
    nim, 
    nama_mahasiswa, 
    prodi 
FROM mahasiswa 
WHERE id_mahasiswa IN (
    SELECT k.id_mahasiswa 
    FROM krs k
    JOIN detail_krs dk ON k.id_krs = dk.id_krs
    JOIN kelas kl ON dk.id_kelas = kl.id_kelas
    JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
    WHERE mk.nama_mk = 'Basis Data'
);


-- ---------------------------------------------------
-- 4. PERANCANGAN & PENGGUNAAN VIEW
-- ---------------------------------------------------

-- 4.1 Membuat VIEW Transkrip/KRS Mahasiswa
CREATE OR REPLACE VIEW v_transkrip_mahasiswa AS
SELECT 
    m.nim,
    m.nama_mahasiswa,
    m.prodi,
    mk.kode_mk,
    mk.nama_mk,
    mk.sks,
    dk.nilai_angka,
    dk.nilai_huruf
FROM detail_krs dk
JOIN krs k ON dk.id_krs = k.id_krs
JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk;

-- 4.2 Memanggil data dari VIEW
SELECT * FROM v_transkrip_mahasiswa WHERE nim = '25430097';