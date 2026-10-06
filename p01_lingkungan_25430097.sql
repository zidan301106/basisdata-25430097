-- p01_lingkungan_25430097.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.

-- Konfigurasi Lingkungan Kerja Kopma
CREATE DATABASE IF NOT EXISTS kopma_097 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_097'@'localhost' 
  IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON kopma_097.* TO 'mhs_097'@'localhost';

-- Konfigurasi Proyek Akademik
CREATE DATABASE IF NOT EXISTS akad_097 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_097'@'localhost' 
  IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON akad_097.* TO 'dev_097'@'localhost';