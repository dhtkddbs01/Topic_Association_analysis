-- Active: 1710827045184@@127.0.0.1@3306
use e_commerce;

-- uesr table 로드 --
CREATE TABLE user (
    id INT(7) NOT NULL,
    type VARCHAR(4),
    state VARCHAR(12),
    created_at DATETIME,
    updated_at DATETIME,
    last_login_at DATETIME,
    username VARCHAR(40)
);
LOAD DATA LOCAL INFILE 'C:/Users/oh/Desktop/project/e-cummerce_project/e-cormerce_project/user-9968.csv'
INTO TABLE user
FIELDS TERMINATED BY ',' ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, type, state, created_at, last_login_at, updated_at, username);

-- refund table 불러오기 --
CREATE TABLE refund (
    id INT(7) NOT NULL,
    type VARCHAR(4),
    state VARCHAR(12),
    created_at DATETIME,
    updated_at DATETIME,
    user_id INT(7),
    course_id INT(6) NULL,
    amount INT(7),
    tax_free_amount INT(7)
);

LOAD DATA LOCAL INFILE 'C:/Users/oh/Desktop/project/e-cummerce_project/e-cormerce_project/refund-9968.csv'
INTO TABLE refund
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- order order 테이블 불러오기 --
CREATE TABLE ord (
    id INT(7) NOT NULL,
    type VARCHAR(4),
    state VARCHAR(12),
    name VARCHAR(30),
    created_at DATETIME,
    updated_at DATETIME,
    customer_id INT(7),
    list_price INT(7),
    sale_price INT(7),
    discount_price INT(7),
    tax_free_amount INT(7)
);

LOAD DATA LOCAL INFILE 'C:/Users/oh/Desktop/project/e-cummerce_project/e-cormerce_project/order-9968.txt'
INTO TABLE ord
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- course order 테이블 불러오기 --
CREATE TABLE course (
    id INT(7) NOT NULL,
    type VARCHAR(4),
    state VARCHAR(12),
    created_at DATETIME,
    updated_at DATETIME,
    title VARCHAR(30),
    description TEXT,
    close_at DATETIME,
    total_class_hours INT(4) NULL,
    keywords TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/oh/Desktop/project/e-cummerce_project/e-cormerce_project/course-9968.csv'
INTO TABLE course
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, type, state, created_at, updated_at, title, @dummy_description, @dummy_close_at, @dummy_total_class_hours, @dummy_keywords)
SET description = NULLIF(@dummy_description, 'NULL'),
    close_at = NULLIF(@dummy_close_at, 'NULL'),
    total_class_hours = NULLIF(@dummy_total_class_hours, 'NULL'),
    keywords = NULLIF(@dummy_keywords, 'NULL');

-- customer order 테이블 불러오기 --
CREATE TABLE customer (
    id INT(7) NOT NULL,
    type VARCHAR(4),
    state VARCHAR(12),
    created_at DATETIME,
    updated_at DATETIME,
    user_id INT(7),
    name VARCHAR(12),
    phone INT(10),
    email VARCHAR(35)
);

LOAD DATA LOCAL INFILE 'C:/Users/oh/Desktop/project/e-cummerce_project/e-cormerce_project/customer-9968.csv'
INTO TABLE customer
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, type, state, @created_at_temp, @updated_at_temp, user_id, name, phone, email)
SET created_at = STR_TO_DATE(@created_at_temp, '%m/%d/%Y %H:%i'),
    updated_at = STR_TO_DATE(@updated_at_temp, '%m/%d/%Y %H:%i');