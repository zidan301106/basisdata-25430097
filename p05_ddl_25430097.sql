-- ============================================================
-- Berkas: p05_ddl_25430097.sql
-- Tugas Mandiri Modul 5: DDL dan Constraint Proyek SIAKAD
-- NPM  : 25430097
-- Nama : Muhammad Zidan Ilham
-- Tema : Akademik (siakad_097)
-- ============================================================

USE siakad_097;

-- 1. DROP TABLE IF EXISTS (Urutan: Tabel Anak -> Tabel Induk)
DROP TABLE IF EXISTS detail_krs;
DROP TABLE IF EXISTS krs;
DROP TABLE IF EXISTS kelas;
DROP TABLE IF EXISTS mata_kuliah;
DROP TABLE IF EXISTS dosen;
DROP TABLE IF EXISTS mahasiswa;

-- 2. TABEL INDUK: Mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT NOT NULL AUTO_INCREMENT,
    nim CHAR(8) NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    prodi VARCHAR(60) NOT NULL,
    no_hp VARCHAR(15) NULL,
    email VARCHAR(100) NULL,
    status_akademik ENUM('aktif', 'cuti', 'lulus', 'drop_out') NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_mahasiswa),
    CONSTRAINT uq_mahasiswa_nim UNIQUE (nim)
) ENGINE=InnoDB;

-- 3. TABEL INDUK: Dosen
CREATE TABLE dosen (
    id_dosen INT NOT NULL AUTO_INCREMENT,
    nidn CHAR(10) NOT NULL,
    nama_dosen VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15) NULL,
    email VARCHAR(100) NULL,
    status_dosen ENUM('aktif', 'pensiun', 'tugas_belajar') NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_dosen),
    CONSTRAINT uq_dosen_nidn UNIQUE (nidn)
) ENGINE=InnoDB;

-- 4. TABEL INDUK: Mata Kuliah
CREATE TABLE mata_kuliah (
    id_mk INT NOT NULL AUTO_INCREMENT,
    kode_mk VARCHAR(10) NOT NULL,
    nama_mk VARCHAR(100) NOT NULL,
    sks TINYINT NOT NULL,
    semester_paket TINYINT NOT NULL,
    PRIMARY KEY (id_mk),
    CONSTRAINT uq_mk_kode UNIQUE (kode_mk),
    CONSTRAINT ck_mk_sks CHECK (sks >= 1 AND sks <= 6)
) ENGINE=InnoDB;

-- 5. TABEL TRANSAKSI: Kelas Perkuliahan
CREATE TABLE kelas (
    id_kelas INT NOT NULL AUTO_INCREMENT,
    kode_kelas VARCHAR(15) NOT NULL,
    id_mk INT NOT NULL,
    id_dosen INT NOT NULL,
    ruang VARCHAR(20) NOT NULL,
    jadwal_hari_jam VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_kelas),
    CONSTRAINT uq_kelas_kode UNIQUE (kode_kelas),
    CONSTRAINT fk_kelas_mk FOREIGN KEY (id_mk) REFERENCES mata_kuliah (id_mk),
    CONSTRAINT fk_kelas_dosen FOREIGN KEY (id_dosen) REFERENCES dosen (id_dosen)
) ENGINE=InnoDB;

-- 6. TABEL TRANSAKSI: Kepala KRS
CREATE TABLE krs (
    id_krs INT NOT NULL AUTO_INCREMENT,
    no_krs VARCHAR(15) NOT NULL,
    id_mahasiswa INT NOT NULL,
    id_dosen_pa INT NOT NULL,
    tahun_akademik CHAR(9) NOT NULL,
    semester ENUM('ganjil', 'genap') NOT NULL,
    tanggal_krs DATE NOT NULL,
    status_persetujuan ENUM('pending', 'disetujui', 'ditolak') NOT NULL DEFAULT 'pending',
    PRIMARY KEY (id_krs),
    CONSTRAINT uq_krs_no UNIQUE (no_krs),
    CONSTRAINT fk_krs_mahasiswa FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa (id_mahasiswa),
    CONSTRAINT fk_krs_dosen_pa FOREIGN KEY (id_dosen_pa) REFERENCES dosen (id_dosen)
) ENGINE=InnoDB;

-- 7. TABEL DETAIL TRANSAKSI: Detail KRS
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_kelas INT NOT NULL,
    nilai_angka DECIMAL(5,2) NULL,
    nilai_huruf ENUM('A', 'B', 'C', 'D', 'E') NULL,
    PRIMARY KEY (id_krs, id_kelas),
    CONSTRAINT fk_dkrs_krs FOREIGN KEY (id_krs) REFERENCES krs (id_krs) ON DELETE CASCADE,
    CONSTRAINT fk_dkrs_kelas FOREIGN KEY (id_kelas) REFERENCES kelas (id_kelas),
    CONSTRAINT ck_dkrs_nilai CHECK (nilai_angka >= 0.00 AND nilai_angka <= 100.00)
) ENGINE=InnoDB;