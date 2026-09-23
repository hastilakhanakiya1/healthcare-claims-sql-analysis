-- Healthcare Claims SQL Analysis
-- Analysis Queries
-- Uses synthetic healthcare claims data for portfolio purposes.



-- 1. MEMBER ELIGIBILITY VALIDATION

SELECT
    c.claim_id,
    m.member_name,
    c.service_date,
    e.coverage_start,
    e.coverage_end,
    c.claim_status,
    c.denial_reason,
    CASE
        WHEN c.service_date BETWEEN e.coverage_start AND e.coverage_end
            THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS eligibility_check
FROM claims c
JOIN members m
    ON c.member_id = m.member_id
JOIN eligibility e
    ON c.member_id = e.member_id
ORDER BY c.claim_id;


-- 2. DENIAL REASON ANALYSIS


SELECT
    denial_reason,
    COUNT(*) AS denied_claims,
    SUM(claim_amount) AS denied_amount
FROM claims
WHERE claim_status = 'Denied'
GROUP BY denial_reason
ORDER BY denied_amount DESC;



-- 3. CLAIMS KPI SUMMARY


SELECT
    COUNT(*) AS total_claims,

    SUM(CASE
        WHEN claim_status = 'Approved' THEN 1
        ELSE 0
    END) AS approved_claims,

    SUM(CASE
        WHEN claim_status = 'Denied' THEN 1
        ELSE 0
    END) AS denied_claims,

    SUM(CASE
        WHEN claim_status = 'Pending' THEN 1
        ELSE 0
    END) AS pending_claims,

    ROUND(SUM(claim_amount), 2) AS total_claim_amount,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN claim_status = 'Denied' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS denial_rate_percent

FROM claims;



-- 4. PROVIDER-LEVEL DENIAL ANALYSIS



SELECT
    p.provider_name,
    p.network_status,
    COUNT(c.claim_id) AS total_claims,

    SUM(CASE
        WHEN c.claim_status = 'Denied' THEN 1
        ELSE 0
    END) AS denied_claims,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN c.claim_status = 'Denied' THEN 1
            ELSE 0
        END) / COUNT(c.claim_id),
        2
    ) AS denial_rate_percent,

    ROUND(SUM(c.claim_amount), 2) AS total_claim_amount

FROM claims c
JOIN providers p
    ON c.provider_id = p.provider_id

GROUP BY
    p.provider_id,
    p.provider_name,
    p.network_status

ORDER BY denial_rate_percent DESC;



-- 5. DATA QUALITY VALIDATION


SELECT
    c.claim_id,
    m.member_name,
    p.provider_name,
    p.network_status,
    c.service_date,
    e.coverage_end,
    c.claim_status,
    c.denial_reason,

    CASE
        WHEN c.service_date NOT BETWEEN
             e.coverage_start AND e.coverage_end
             AND c.denial_reason != 'Member Not Eligible'
            THEN 'Review - Eligibility Mismatch'

        WHEN p.network_status = 'Out-of-Network'
             AND c.claim_status != 'Denied'
            THEN 'Review - Network Mismatch'

        WHEN c.claim_status = 'Denied'
             AND c.denial_reason IS NULL
            THEN 'Review - Missing Denial Reason'

        ELSE 'No Issue'
    END AS data_quality_flag

FROM claims c
JOIN members m
    ON c.member_id = m.member_id
JOIN eligibility e
    ON c.member_id = e.member_id
JOIN providers p
    ON c.provider_id = p.provider_id

ORDER BY c.claim_id;
