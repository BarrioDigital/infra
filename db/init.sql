-- =========================================================
-- BarrioDigital
-- Base de datos general para todos los microservicios
-- =========================================================

CREATE DATABASE IF NOT EXISTS db_barriodigital
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'barriouser'@'%'
IDENTIFIED BY 'barriopassword';

GRANT ALL PRIVILEGES
ON db_barriodigital.*
TO 'barriouser'@'%';

FLUSH PRIVILEGES;

USE db_barriodigital;


-- =========================================================
-- CATÁLOGO
-- ms-barriodigital-catalog
-- =========================================================

CREATE TABLE IF NOT EXISTS procedures (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    requirements TEXT,
    daily_quota INT NOT NULL DEFAULT 0,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);


-- =========================================================
-- TRÁMITES
-- ms-barriodigital-requests
-- =========================================================

CREATE TABLE IF NOT EXISTS requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    procedure_id BIGINT NOT NULL,
    citizen_id VARCHAR(150) NOT NULL,

    status ENUM(
        'INGRESADO',
        'ADMITIDO',
        'EN_GESTION',
        'EN_TERRENO',
        'RESUELTO',
        'RECHAZADO'
    ) NOT NULL DEFAULT 'INGRESADO',

    description TEXT,
    assigned_operator_id VARCHAR(150),
    assigned_crew VARCHAR(150),

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    resolved_at DATETIME NULL,

    CONSTRAINT fk_requests_procedure
        FOREIGN KEY (procedure_id)
        REFERENCES procedures(id)
);


-- =========================================================
-- AUDITORÍA
-- ms-barriodigital-audit
-- =========================================================

CREATE TABLE IF NOT EXISTS audit_events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    event_id VARCHAR(100) NOT NULL UNIQUE,
    request_id BIGINT,
    event_type VARCHAR(100) NOT NULL,

    user_id VARCHAR(150),
    user_role VARCHAR(100),

    old_status VARCHAR(50),
    new_status VARCHAR(50),

    event_timestamp DATETIME NOT NULL,

    trace_id VARCHAR(100),
    correlation_id VARCHAR(100),

    details TEXT,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_audit_request (request_id),
    INDEX idx_audit_user (user_id),
    INDEX idx_audit_type (event_type),
    INDEX idx_audit_timestamp (event_timestamp)
);


-- =========================================================
-- REPORTERÍA
-- ms-barriodigital-report
-- =========================================================

CREATE TABLE IF NOT EXISTS report_events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    event_id VARCHAR(100) NOT NULL UNIQUE,
    request_id BIGINT,

    procedure_id BIGINT,
    procedure_name VARCHAR(150),

    event_type VARCHAR(100) NOT NULL,

    status VARCHAR(50),
    previous_status VARCHAR(50),

    event_timestamp DATETIME NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_report_request (request_id),
    INDEX idx_report_procedure (procedure_id),
    INDEX idx_report_status (status),
    INDEX idx_report_timestamp (event_timestamp)
);


-- =========================================================
-- DATOS DE PRUEBA
-- =========================================================

INSERT INTO procedures
    (name, description, requirements, daily_quota)
SELECT
    'Retiro de residuos voluminosos',
    'Solicitud municipal para retiro de residuos voluminosos',
    'Indicar dirección y descripción de los residuos',
    20
WHERE NOT EXISTS (
    SELECT 1
    FROM procedures
    WHERE name = 'Retiro de residuos voluminosos'
);


INSERT INTO procedures
    (name, description, requirements, daily_quota)
SELECT
    'Reparación de luminaria',
    'Solicitud para informar luminaria pública con desperfectos',
    'Indicar ubicación de la luminaria',
    30
WHERE NOT EXISTS (
    SELECT 1
    FROM procedures
    WHERE name = 'Reparación de luminaria'
);