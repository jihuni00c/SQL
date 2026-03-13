CREATE DATABASE IF NOT EXISTS customer_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE customer_db;

CREATE TABLE IF NOT EXISTS customer (
	no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age TINYINT,
    phone VARCHAR(20),
    email VARCHAR(30) NOT NULL,
    address VARCHAR(50)
);

DESC customer;

SELECT * FROM customer;

/*
데이터베이스 생성 후 테이블 생성 -> 깜빡잊고 중요한 컬럼 생성을 누락!
최초에 테이블을 생성했던 시점에서는 불필요 -> 시간 경과 후 어떤 컬럼이 필요!

ALTER TABLE <tablename> ADD COLUMN <추가할 컬럼명> <추가할 컬럼 데이터형 = 스키마>
ALTER TABLE customer ADD COLUMN job VARCHAR(10) NOT NULL

최초에 컬럼을 생성했던 시점에서는 특정 컬럼이 작은 정수타입이면 될줄알았는데,
시간이 경과해서 큰 정수값을 허용해야하는 경우 발생 -> 컬럼의 타입 변경 필요!

ALTER TABLE <tablename> MODISY COLUMN <변경할 컬럼명> <변경할 컬럼 데이터형 = 스키마>
ALTER TABLE customer MODIFY COLUMN age INT NOT NULL;

최초에 컬럼을 생성할 때와 달리 컬럼의 기능(성격)이 많이 변질 -> 컬럼명을 변경해야하는 상황이 발생

ALTER TABLE <tablename> CHANGE COLUMN <기존컬럼명><변경할컬럼명><변경할 컬럼 데이터형 = 스키마>
ALTER TABLE customer CHANGE COLUMN phone mobile VARCHAR(30) NOT NULL;

특정 컬럼이 아예 불필요해졌음!
ALTER TABLE <tablename> DROP COLUMN <삭제할 컬럼명>
ALTER TABLE customer DROP COLUMN address;
*/

