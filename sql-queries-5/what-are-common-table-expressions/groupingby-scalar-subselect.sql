-- Grouping by a Column Derived from a Scalar Subselect or Non-Deterministic Function
WITH AgeCategories AS ( 
    SELECT s.id AS student_id, 
            s.name AS student_name, 
            TIMESTAMPDIFF(YEAR, s.birth_date, s.enrollment_date) AS age_at_enrollment, 
            CASE 
                WHEN TIMESTAMPDIFF(YEAR, s.birth_date, s.enrollment_date) < 20 THEN 'Under 20' 
                WHEN TIMESTAMPDIFF(YEAR, s.birth_date, s.enrollment_date) BETWEEN 20 AND 30 THEN '20-30' 
                ELSE 'Over 30' 
            END AS age_category 
    FROM Student AS s 
    ) 
    SELECT age_category, 
            COUNT(student_id) AS student_count 
    FROM AgeCategories 
    GROUP BY age_category;