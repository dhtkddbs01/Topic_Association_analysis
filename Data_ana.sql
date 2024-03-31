-- Active: 1711884783063@@127.0.0.1@3306@e_commerce
use e_commerce;

-- 데이터 확인 --
select * from course;

select * from customer;

select * from refund;

select * from user;

select * from ord;

-- 테이블들을 하나로 조인시키기 -- 
-- 중복되는 컬럼과 분석에 필요하지 않은 개인적인 정보(ex.핸드폰 번호, 이메일 등 제외)
select c.type, c.state, c.created_at, c.updated_at, c.user_id, c.id as customer_id, u.last_login_at, o.id as order_id, o.state as order_state, o.created_at as order_created, o.updated_at as order_updated, o.list_price, o.sale_price
from customer c
left join user u on c.user_id = u.id
right join ord o on c.id = o.customer_id
left join refund r on r.course_id = 
left join course e on r.course_id = e.id
;


SELECT
    prev_price,
    y_m,
    sum_price,
    sum_price - prev_price AS dif_price
FROM (
    SELECT 
        LAG(sum_price) OVER (ORDER BY y_m) AS prev_price,
        y_m,
        sum_price
    FROM (
        SELECT 
            SUM(list_price) AS sum_price,
            SUBSTRING(created_at, 1, 7) AS y_m
        FROM 
            ord
        GROUP BY 
            y_m
    ) AS subquery1
) AS subquery2
ORDER BY 
    y_m;

SELECT 
    sum_price, 
    m_d
FROM (
    SELECT 
        SUM(list_price) AS sum_price, 
        SUBSTRING(updated_at, 1, 10) AS m_d
    FROM 
        ord -- 여기에 실제 테이블 이름을 입력하세요.
    WHERE 
        state = "COMPLETED"
    GROUP BY 
        m_d
) AS subquery1
ORDER BY 
    sum_price DESC
LIMIT 3;
SELECT 
    sum_price, 
    m_d
FROM (
    SELECT 
        SUM(list_price) AS sum_price, 
        SUBSTRING(updated_at, 1, 10) AS m_d
    FROM 
        ord -- 여기에 실제 테이블 이름을 입력하세요.
    WHERE 
        state = "COMPLETED"
    GROUP BY 
        m_d
) AS subquery1
ORDER BY 
    sum_price asc
LIMIT 3;

