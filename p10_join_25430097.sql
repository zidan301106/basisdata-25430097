-- =====================================================================
-- Praktikum Basis Data - Modul 10 (Menghubungkan Tabel dengan JOIN)
-- Berkas   : p10_join_25430097.sql
-- Nama     : Muhammad Zidan Ilham
-- NPM      : 25430097
-- Database : siakad_097
-- =====================================================================

USE siakad_097;

-- Mengaktifkan mode ketat pengelompokan
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- ---------------------------------------------------------------------
-- KI-01: Daftar Kelas Perkuliahan Lengkap Beserta Mata Kuliah & Dosen Pengampu
-- Jenis JOIN : INNER JOIN (3 Tabel)
-- Jalur ERD  : kelas -> mata_kuliah (id_mk), kelas -> dosen (id_dosen)
-- ---------------------------------------------------------------------
SELECT 
    kl.kode_kelas,
    mk.kode_mk,
    mk.nama_mk,
    mk.sks,
    d.nama_dosen AS dosen_pengampu,
    kl.ruang,
    kl.jadwal_hari_jam
FROM kelas kl
INNER JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
INNER JOIN dosen d ON kl.id_dosen = d.id_dosen
ORDER BY kl.kode_kelas ASC;

-- ---------------------------------------------------------------------
-- KI-02: Transkrip Nilai Lengkap Mahasiswa (Join 5 Tabel + Agregasi)
-- Jenis JOIN : INNER JOIN (5 Tabel)
-- Jalur ERD  : mahasiswa -> krs -> detail_krs -> kelas -> mata_kuliah
-- ---------------------------------------------------------------------
SELECT 
    m.nim,
    m.nama_mahasiswa,
    mk.kode_mk,
    mk.nama_mk,
    mk.sks,
    dk.nilai_angka,
    dk.nilai_huruf
FROM mahasiswa m
INNER JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
INNER JOIN detail_krs dk ON k.id_krs = dk.id_krs
INNER JOIN kelas kl ON dk.id_kelas = kl.id_kelas
INNER JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
ORDER BY m.nim ASC, mk.kode_mk ASC;

-- ---------------------------------------------------------------------
-- KI-03: Mendeteksi Mahasiswa yang Belum Pernah Mengajukan KRS (Data Tanpa Pasangan)
-- Jenis JOIN : LEFT JOIN + HAVING COUNT(...) = 0
-- Jalur ERD  : mahasiswa (kiri) -> krs (kanan)
-- ---------------------------------------------------------------------
SELECT 
    m.nim,
    m.nama_mahasiswa,
    m.prodi,
    m.status_akademik,
    COUNT(k.id_krs) AS jumlah_dokumen_krs
FROM mahasiswa m
LEFT JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
GROUP BY m.id_mahasiswa, m.nim, m.nama_mahasiswa, m.prodi, m.status_akademik
HAVING COUNT(k.id_krs) = 0;

-- ---------------------------------------------------------------------
-- KI-04: Mendeteksi Dosen yang Belum Memiliki Jadwal Mengajar Kelas
-- Jenis JOIN : LEFT JOIN + IS NULL
-- Jalur ERD  : dosen (kiri) -> kelas (kanan)
-- ---------------------------------------------------------------------
SELECT 
    d.nidn,
    d.nama_dosen,
    d.status_dosen
FROM dosen d
LEFT JOIN kelas kl ON d.id_dosen = kl.id_dosen
WHERE kl.id_kelas IS NULL;

-- ---------------------------------------------------------------------
-- KI-05: Pasangan Mahasiswa dari Program Studi yang Sama (Self Join)
-- Jenis JOIN : SELF JOIN (mahasiswa m1 -> mahasiswa m2)
-- Jalur ERD  : mahasiswa (m1.prodi) <-> mahasiswa (m2.prodi)
-- ---------------------------------------------------------------------
SELECT 
    m1.prodi AS program_studi,
    m1.nim AS nim_mahasiswa_1,
    m1.nama_mahasiswa AS nama_mahasiswa_1,
    m2.nim AS nim_mahasiswa_2,
    m2.nama_mahasiswa AS nama_mahasiswa_2
FROM mahasiswa m1
INNER JOIN mahasiswa m2 
    ON m1.prodi = m2.prodi 
    AND m1.id_mahasiswa < m2.id_mahasiswa
ORDER BY m1.prodi ASC, m1.nim ASC
LIMIT 15;