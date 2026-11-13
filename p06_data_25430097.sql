-- ===================================================
-- PRAKTIKUM BASIS DATA - MODUL 6 (DML)
-- Nama : Muhammad Zidan Ilham
-- NPM  : 25430097
-- File : p06_data_25430097.sql
-- Database: siakad_097
-- Parameter P = (97 mod 9) + 1 = 8
-- Ketentuan Data: 
--   - Tabel Master min. 5 baris
--   - Tabel Transaksi min. 80 baris (10 x P = 80)
-- ===================================================

-- USE siakad_097;

-- Nonaktifkan pemeliharaan integritas referensial sementara untuk reset data bersih
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE detail_krs;
TRUNCATE TABLE krs;
TRUNCATE TABLE kelas;
TRUNCATE TABLE mata_kuliah;
TRUNCATE TABLE dosen;
TRUNCATE TABLE mahasiswa;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------
-- 1. OPERASI INSERT (Pengisian Data Sampel)
-- ---------------------------------------------------

-- A. Pengisian Tabel Induk: mahasiswa (10 Baris Data)
INSERT INTO mahasiswa (id_mahasiswa, nim, nama_mahasiswa, prodi, no_hp, email, status_akademik) VALUES 
(1, '25430097', 'Muhammad Zidan Ilham', 'Informatika', '081234567890', 'zidan@example.com', 'aktif'),
(2, '25430001', 'Ahmad Rizky Pratama', 'Informatika', '081234567891', 'rizky@example.com', 'aktif'),
(3, '25430002', 'Siti Nurhaliza', 'Sistem Informasi', '081234567892', 'siti@example.com', 'aktif'),
(4, '25430003', 'Budi Santoso', 'Teknik Informatika', '081234567893', 'budi@example.com', 'aktif'),
(5, '25430004', 'Dewi Lestari', 'Informatika', '081234567894', 'dewi@example.com', 'aktif'),
(6, '25430005', 'Eko Prasetyo', 'Sistem Informasi', '081234567895', 'eko@example.com', 'nonaktif'),
(7, '25430006', 'Fanya Fitriani', 'Teknik Informatika', '081234567896', 'fanya@example.com', 'aktif'),
(8, '25430007', 'Gilang Ramadhan', 'Informatika', '081234567897', 'gilang@example.com', 'aktif'),
(9, '25430008', 'Hany Handayani', 'Sistem Informasi', '081234567898', 'hany@example.com', 'aktif'),
(10, '25430009', 'Indra Wijaya', 'Informatika', '081234567899', 'indra@example.com', 'aktif');

-- B. Pengisian Tabel Induk: dosen (5 Baris Data)
INSERT INTO dosen (id_dosen, nidn, nama_dosen, email) VALUES 
(1, '0012058001', 'Dr. Hendra Suhatril, M.T.', 'hendra@example.com'),
(2, '0015088202', 'Dedi Irawan, S.Kom., M.T.I.', 'dedi@example.com'),
(3, '0020017503', 'Prof. Dr. Ir. Gunawan, M.Sc.', 'gunawan@example.com'),
(4, '0010118804', 'Anita Rahmawati, M.Kom.', 'anita@example.com'),
(5, '0005049005', 'Fajar Ramadhan, M.T.', 'fajar@example.com');

-- C. Pengisian Tabel Induk: mata_kuliah (8 Baris Data)
INSERT INTO mata_kuliah (id_mk, kode_mk, nama_mk, sks) VALUES 
(1, 'TIF101', 'Basis Data', 3),
(2, 'TIF102', 'Algoritma dan Pemrograman', 4),
(3, 'TIF103', 'Struktur Data', 3),
(4, 'TIF104', 'Pemrograman Web', 3),
(5, 'TIF105', 'Jaringan Komputer', 3),
(6, 'TIF106', 'Sistem Operasi', 3),
(7, 'TIF107', 'Matematika Diskrit', 2),
(8, 'TIF108', 'Bahasa Inggris Teknis', 2);

-- D. Pengisian Tabel Induk/Antara: kelas (9 Baris Data)
INSERT INTO kelas (id_kelas, kode_kelas, id_mk, id_dosen, ruang, jadwal_hari_jam) VALUES 
(1, 'TIF-A1', 1, 2, 'Lab Komputer 1', 'Senin, 08:00 - 10:30'),
(2, 'TIF-A2', 1, 2, 'Lab Komputer 2', 'Senin, 10:30 - 13:00'),
(3, 'TIF-B1', 2, 1, 'Ruang Teori 201', 'Selasa, 08:00 - 11:30'),
(4, 'TIF-B2', 3, 3, 'Lab Komputer 3', 'Rabu, 09:00 - 11:30'),
(5, 'TIF-C1', 4, 4, 'Lab Komputer 1', 'Kamis, 13:00 - 15:30'),
(6, 'TIF-C2', 5, 5, 'Lab Jaringan', 'Jumat, 08:00 - 10:30'),
(7, 'TIF-D1', 6, 1, 'Ruang Teori 202', 'Selasa, 13:00 - 15:30'),
(8, 'TIF-D2', 7, 3, 'Ruang Teori 101', 'Rabu, 13:00 - 14:40'),
(9, 'TIF-E1', 8, 4, 'Ruang Teori 102', 'Kamis, 08:00 - 09:40');

-- E. Pengisian Tabel Transaksi: krs (10 Baris Utama pada 5 Tanggal Berbeda)
INSERT INTO krs (id_krs, no_krs, id_mahasiswa, id_dosen_pa, tahun_akademik, semester, tanggal_krs, status_persetujuan) VALUES 
(1, 'KRS-20261-001', 1, 2, '2026/2027', 'ganjil', '2026-10-15', 'disetujui'),
(2, 'KRS-20261-002', 2, 2, '2026/2027', 'ganjil', '2026-10-15', 'disetujui'),
(3, 'KRS-20261-003', 3, 1, '2026/2027', 'ganjil', '2026-10-16', 'disetujui'),
(4, 'KRS-20261-004', 4, 3, '2026/2027', 'ganjil', '2026-10-16', 'disetujui'),
(5, 'KRS-20261-005', 5, 2, '2026/2027', 'ganjil', '2026-10-17', 'disetujui'),
(6, 'KRS-20261-006', 7, 4, '2026/2027', 'ganjil', '2026-10-17', 'disetujui'),
(7, 'KRS-20261-007', 8, 2, '2026/2027', 'ganjil', '2026-10-18', 'disetujui'),
(8, 'KRS-20261-008', 9, 5, '2026/2027', 'ganjil', '2026-10-18', 'disetujui'),
(9, 'KRS-20261-009', 10, 2, '2026/2027', 'ganjil', '2026-10-19', 'disetujui'),
(10, 'KRS-20261-010', 6, 1, '2026/2027', 'ganjil', '2026-10-19', 'pending');

-- F. Pengisian Tabel Detail Transaksi: detail_krs (Total 80 Baris Data Transaksi: 10 x P = 80, P=8)
INSERT INTO detail_krs (id_krs, id_kelas, nilai_angka, nilai_huruf) VALUES 
-- Transaksi KRS 1 (Mahasiswa 1: 8 Kelas)
(1, 1, 88.50, 'A'), (1, 3, 85.00, 'A'), (1, 4, 78.00, 'B'), (1, 5, 92.00, 'A'),
(1, 6, 80.50, 'A'), (1, 7, 75.00, 'B'), (1, 8, 87.00, 'A'), (1, 9, 90.00, 'A'),

-- Transaksi KRS 2 (Mahasiswa 2: 8 Kelas)
(2, 1, 82.00, 'A'), (2, 3, 76.50, 'B'), (2, 4, 88.00, 'A'), (2, 5, 84.00, 'A'),
(2, 6, 79.00, 'B'), (2, 7, 85.50, 'A'), (2, 8, 91.00, 'A'), (2, 9, 83.00, 'A'),

-- Transaksi KRS 3 (Mahasiswa 3: 8 Kelas)
(3, 2, 90.00, 'A'), (3, 3, 81.00, 'A'), (3, 4, 75.50, 'B'), (3, 5, 87.00, 'A'),
(3, 6, 88.00, 'A'), (3, 7, 72.00, 'B'), (3, 8, 86.00, 'A'), (3, 9, 89.00, 'A'),

-- Transaksi KRS 4 (Mahasiswa 4: 8 Kelas)
(4, 1, 70.00, 'B'), (4, 3, 74.00, 'B'), (4, 4, 80.00, 'A'), (4, 5, 78.50, 'B'),
(4, 6, 82.00, 'A'), (4, 7, 76.00, 'B'), (4, 8, 85.00, 'A'), (4, 9, 88.00, 'A'),

-- Transaksi KRS 5 (Mahasiswa 5: 8 Kelas)
(5, 1, 95.00, 'A'), (5, 3, 89.00, 'A'), (5, 4, 91.50, 'A'), (5, 5, 93.00, 'A'),
(5, 6, 87.00, 'A'), (5, 7, 84.00, 'A'), (5, 8, 90.00, 'A'), (5, 9, 92.50, 'A'),

-- Transaksi KRS 6 (Mahasiswa 7: 8 Kelas)
(6, 2, 77.00, 'B'), (6, 3, 80.00, 'A'), (6, 4, 83.50, 'A'), (6, 5, 76.00, 'B'),
(6, 6, 85.00, 'A'), (6, 7, 79.00, 'B'), (6, 8, 88.00, 'A'), (6, 9, 86.50, 'A'),

-- Transaksi KRS 7 (Mahasiswa 8: 8 Kelas)
(7, 1, 84.00, 'A'), (7, 3, 86.00, 'A'), (7, 4, 88.50, 'A'), (7, 5, 90.00, 'A'),
(7, 6, 82.50, 'A'), (7, 7, 78.00, 'B'), (7, 8, 87.00, 'A'), (7, 9, 89.50, 'A'),

-- Transaksi KRS 8 (Mahasiswa 9: 8 Kelas)
(8, 2, 73.00, 'B'), (8, 3, 75.00, 'B'), (8, 4, 81.00, 'A'), (8, 5, 79.50, 'B'),
(8, 6, 84.00, 'A'), (8, 7, 77.00, 'B'), (8, 8, 86.00, 'A'), (8, 9, 85.00, 'A'),

-- Transaksi KRS 9 (Mahasiswa 10: 8 Kelas)
(9, 1, 91.00, 'A'), (9, 3, 93.50, 'A'), (9, 4, 89.00, 'A'), (9, 5, 94.00, 'A'),
(9, 6, 90.50, 'A'), (9, 7, 86.00, 'A'), (9, 8, 92.00, 'A'), (9, 9, 95.00, 'A'),

-- Transaksi KRS 10 (Mahasiswa 6: 8 Kelas)
(10, 2, 65.00, 'C'), (10, 3, 70.00, 'B'), (10, 4, 68.50, 'C'), (10, 5, 72.00, 'B'),
(10, 6, 69.00, 'C'), (10, 7, 64.00, 'C'), (10, 8, 75.00, 'B'), (10, 9, 78.00, 'B');


-- ---------------------------------------------------
-- 2. OPERASI SELECT (Menampilkan & Menyaring Data)
-- ---------------------------------------------------

-- A. Menampilkan seluruh data mahasiswa aktif
SELECT * FROM mahasiswa WHERE status_akademik = 'aktif';

-- B. Menampilkan data KRS mahasiswa menggunakan penggabungan tabel (JOIN)
SELECT 
    m.nim, 
    m.nama_mahasiswa, 
    mk.nama_mk, 
    kl.kode_kelas, 
    dk.nilai_angka, 
    dk.nilai_huruf
FROM detail_krs dk
JOIN krs k ON dk.id_krs = k.id_krs
JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
JOIN kelas kl ON dk.id_kelas = kl.id_kelas
JOIN mata_kuliah mk ON kl.id_mk = mk.id_mk
LIMIT 10;


-- ---------------------------------------------------
-- 3. OPERASI UPDATE (Pembaruan Data & Mode Aman)
-- ---------------------------------------------------

-- Mengaktifkan mode aman (sql_safe_updates)
SET SESSION sql_safe_updates = 1;

-- Memperbarui nilai angka dan huruf pada detail KRS dengan klausa WHERE kolom kunci komposit
UPDATE detail_krs 
SET nilai_angka = 95.00, nilai_huruf = 'A' 
WHERE id_krs = 1 AND id_kelas = 1;


-- ---------------------------------------------------
-- 4. OPERASI DELETE (Pengujian Penghapusan Data)
-- ---------------------------------------------------

-- Menguji penghapusan baris pada krs (Menguji fitur ON DELETE CASCADE pada detail_krs)
DELETE FROM krs WHERE id_krs = 10;