-- Healthcare Claims Business Insights
-- Business-focused analysis of claim denials, eligibility,
-- provider performance, and financial impact.


-- 1. CLAIMS SUMMARY

SELECT
    COUNT(*) AS total_claims,
    SUM(claim_amount) AS total_claim_amount,
    COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END) AS approved_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) AS denied_claims,
    COUNT(CASE WHEN claim_status = 'Pending' THEN 1 END) AS pending_claims
FROM claims;


-- 2. DENIAL RATE

SELECT
    ROUND(
        COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) * 100.0
        / COUNT(*),
        1
    ) AS denial_rate_percent
FROM claims;


-- 3. DENIAL REASONS

SELECT
    denial_reason,
    COUNT(*) AS denied_claims,
    SUM(claim_amount) AS denied_amount
FROM claims
WHERE claim_status = 'Denied'
GROUP BY denial_reason
ORDER BY denied_claims DESC;


-- 4. NETWORK STATUS ANALYSIS

SELECT
    p.network_status,
    COUNT(*) AS total_claims,
    COUNT(CASE WHEN c.claim_status = 'Denied' THEN 1 END) AS denied_claims,
    ROUND(
        COUNT(CASE WHEN c.claim_status = 'Denied' THEN 1 END) * 100.0
        / COUNT(*),
        1
    ) AS denial_rate_percent
FROM claims c
JOIN providers p
    ON c.provider_id = p.provider_id
GROUP BY p.network_status
ORDER BY denial_rate_percent DESC;


-- 5. PROVIDER CLAIM AMOUNT ANALYSIS

SELECT
    p.provider_name,
    COUNT(*) AS total_claims,
    SUM(c.claim_amount) AS total_claim_amount
FROM claims c
JOIN providers p
    ON c.provider_id = p.provider_id
GROUP BY p.provider_name
ORDER BY total_claim_amount DESC;


-- 6. ELIGIBILITY EXCEPTIONS

SELECT
    c.claim_id,
    m.member_name,
    c.service_date,
    m.coverage_end,
    c.claim_status,
    c.denial_reason,
    c.service_date - m.coverage_end AS days_after_coverage
FROM claims c
JOIN members m
    ON c.member_id = m.member_id
WHERE c.service_date > m.coverage_end
ORDER BY c.claim_id;


-- 7. PENDING CLAIMS

SELECT
    c.claim_id,
    m.member_name,
    p.provider_name,
    c.service_date,
    c.claim_amount,
    c.claim_status
FROM claims c
JOIN members m
    ON c.member_id = m.member_id
JOIN providers p
    ON c.provider_id = p.provider_id
WHERE c.claim_status = 'Pending'
ORDER BY c.service_date;
