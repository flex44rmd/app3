-- ===========================================
-- انسخ هذا الملف كله والصقه في phpMyAdmin
-- ===========================================

-- 1. تأكد من اختيار قاعدة البيانات: if0_40376337_test

-- 2. أنشئ الجداول
CREATE TABLE IF NOT EXISTS kingdoms (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    points INT DEFAULT 0,
    color_red INT NOT NULL,
    color_green INT NOT NULL,
    color_blue INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pre_assigned_codes (
    code VARCHAR(50) PRIMARY KEY,
    kingdom VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(50) PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    kingdom VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_kingdom (kingdom),
    INDEX idx_code (code),
    INDEX idx_points (points)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS chat_messages (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    kingdom VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_kingdom (kingdom),
    INDEX idx_timestamp (timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. أدخل البيانات الأساسية
INSERT INTO kingdoms (id, name, points, color_red, color_green, color_blue) VALUES
('1', 'Atlantis', 0, 33, 150, 243),
('2', 'Cappadocia', 0, 255, 152, 0),
('3', 'Shield of Faith', 0, 76, 175, 80),
('4', 'Draconia', 0, 244, 67, 54)
ON DUPLICATE KEY UPDATE name=name;

INSERT INTO pre_assigned_codes (code, kingdom, role, is_used) VALUES
('OWNER001', 'Admin', 'owner', FALSE),
('ATL001', 'Atlantis', 'leader', FALSE),
('ATL002', 'Atlantis', 'officer', FALSE),
('ATL003', 'Atlantis', 'soldier', FALSE),
('CAP001', 'Cappadocia', 'leader', FALSE),
('CAP002', 'Cappadocia', 'officer', FALSE),
('CAP003', 'Cappadocia', 'soldier', FALSE),
('SOF001', 'Shield of Faith', 'leader', FALSE),
('SOF002', 'Shield of Faith', 'officer', FALSE),
('SOF003', 'Shield of Faith', 'soldier', FALSE),
('DRA001', 'Draconia', 'leader', FALSE),
('DRA002', 'Draconia', 'officer', FALSE),
('DRA003', 'Draconia', 'soldier', FALSE)
ON DUPLICATE KEY UPDATE code=code;

