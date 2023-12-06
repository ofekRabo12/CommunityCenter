SELECT
    firstName,
    lastName,
    COUNT(*) AS 'Number of registered persons',
    ROUND(SUM(
        secretariat.bonus_per_registration
     * c.classe_price)) AS 'Annual bonus'
FROM
    staff
JOIN secretariat ON staff.staffId = secretariat.sec_id
JOIN registered_toׂ ON secretariat.sec_id = registered_toׂ.signed_him
JOIN classesׂ c ON
    c.classes_id = registered_toׂ.classes_id
GROUP BY
    secretariat.sec_id  
ORDER BY `Annual bonus`  DESC




SELECT
    classes_name,
    COUNT(R.classes_id) AS 'registrants',
    (classe_price * COUNT(*)) AS 'Income per class',
    ROUND(
        (classe_price * COUNT(*)) /(
        SELECT
            SUM(CL.classe_price)
        FROM
            registered_toׂ RG
        JOIN classesׂ CL ON
            RG.classes_id = CL.classes_id
    ) * 100,
    2
    ) AS '(%) Rate of Total Revenue'
FROM
    classesׂ
JOIN registered_toׂ R ON classesׂ.classes_id = R.classes_id
GROUP BY
    classesׂ.classes_id
HAVING
    COUNT(R.classes_id) < 50
ORDER BY
    COUNT(R.classes_id)
DESC




SELECT c.classes_name, ROUND(AVG(s.age)) AS 'average age'
FROM students s
JOIN registered_toׂ r
ON s.student_id = r.student_id
JOIN classesׂ c
ON c.classes_id = r.classes_id
GROUP BY c.classes_id
ORDER BY AVG(s.age)





SELECT gift_name, COUNT(*) AS 'Amount of gifts collected', ROUND(SUM(gift_value)/COUNT(*)) AS 'Gifts value', ROUND(AVG(salary)) AS ' Average salaries of employees who took the gift'
FROM gifts g
JOIN take_gift tg
ON g.gift_id = tg.gift_id
JOIN staff s
ON tg.staff_id = s.staffId
GROUP BY gift_name  
ORDER BY `Gifts value`  DESC






SELECT
    s.firstName, s.lastName, s.city, b.branch_city AS 'work place'
FROM
    staff s
JOIN working_at w ON
    s.staffId = w.staff_id
JOIN branch b ON
    w.branch_id = b.branch_id
WHERE
    s.city <> b.branch_city 
    AND s.salary > 6000
