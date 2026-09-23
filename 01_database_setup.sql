-- Healthcare Claims SQL Analysis
-- Database Setup
-- Synthetic data created for portfolio and SQL practice purposes.


-- 1. MEMBERS

DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    member_name TEXT NOT NULL,
    date_of_birth DATE,
    gender TEXT,
    state TEXT
);

INSERT INTO members VALUES
(1001, 'Aarav Shah', '1992-05-14', 'M', 'NC'),
(1002, 'Riya Patel', '1988-11-22', 'F', 'NC'),
(1003, 'Neha Sharma', '1995-03-08', 'F', 'SC'),
(1004, 'Amit Mehta', '1979-07-19', 'M', 'NC'),
(1005, 'Sara Johnson', '1990-01-30', 'F', 'GA');


-- 2. ELIGIBILITY

DROP TABLE IF EXISTS eligibility;

CREATE TABLE eligibility (
    eligibility_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    coverage_start DATE NOT NULL,
    coverage_end DATE NOT NULL,
    plan_type TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO eligibility VALUES
(1, 1001, '2026-01-01', '2026-12-31', 'Medicaid'),
(2, 1002, '2026-01-01', '2026-12-31', 'Marketplace'),
(3, 1003, '2026-03-01', '2026-12-31', 'Medicaid'),
(4, 1004, '2026-01-01', '2026-08-31', 'Marketplace'),
(5, 1005, '2026-01-01', '2026-12-31', 'Medicaid');


-- 3. PROVIDERS

DROP TABLE IF EXISTS providers;

CREATE TABLE providers (
    provider_id INTEGER PRIMARY KEY,
    provider_name TEXT NOT NULL,
    provider_type TEXT,
    network_status TEXT,
    state TEXT
);

INSERT INTO providers VALUES
(501, 'Charlotte Medical Center', 'Hospital', 'In-Network', 'NC'),
(502, 'Carolina Primary Care', 'Clinic', 'In-Network', 'NC'),
(503, 'Piedmont Specialist Center', 'Specialist', 'Out-of-Network', 'NC'),
(504, 'Peachtree Health Clinic', 'Clinic', 'In-Network', 'GA');



-- 4. CLAIMS


DROP TABLE IF EXISTS claims;

CREATE TABLE claims (
    claim_id TEXT PRIMARY KEY,
    member_id INTEGER NOT NULL,
    provider_id INTEGER NOT NULL,
    service_date DATE NOT NULL,
    claim_amount DECIMAL(10,2),
    claim_status TEXT,
    denial_reason TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

INSERT INTO claims VALUES
('CLM1001', 1001, 501, '2026-07-15', 1250.00, 'Approved', NULL),
('CLM1002', 1002, 502, '2026-08-03', 275.00, 'Approved', NULL),
('CLM1003', 1003, 503, '2026-08-18', 850.00, 'Denied', 'Out-of-Network'),
('CLM1004', 1004, 501, '2026-09-10', 2100.00, 'Denied', 'Member Not Eligible'),
('CLM1005', 1005, 504, '2026-09-12', 425.00, 'Approved', NULL),
('CLM1006', 1002, 503, '2026-09-14', 975.00, 'Denied', 'Out-of-Network'),
('CLM1007', 1001, 502, '2026-09-16', 180.00, 'Pending', NULL),
('CLM1008', 1003, 501, '2026-09-18', 1650.00, 'Approved', NULL);
