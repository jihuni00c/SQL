-- LEFT/RIGHT OUTER JOIN
-- SubQuery VS JOIN
-- WHERE절
-- GROUP BY & HAVING절
-- + 개념
-- INDEX = 목차(색인) = 책 혹은 사전 = 책을 처음부터 다 보지 않고, 원하는 챕터
-- 100만개의 데이터 존재
-- 100만개의 행으로 구성된 테이블
-- 93만 5천 2백 7번째 행의 데이터를 찾아오겠다
-- 1번~93만 5천 2백 6번째 행을 다 읽고 내려가야함
-- Full Table Scan 방식

-- 인덱스 (색인) 기능을 테이블 내 특정 컬럼에 적용!!!
-- MySQL 인덱스 설정 방법 2가지
-- Clustered Index : 테이블을 생성하는 단계에서부터 인덱스로 시작한 요소 (PK)
-- Secondary Index : 의도적으로 인덱스값을 생성하는 방법

-- CREATE INDEX [인덱스명] ON users(email);
-- CREATE INDEX idx_email ON users(email);
-- CREATE FROM users WHERE email = "a@gmail.com"
-- 인덱스를 필요에 의해서 설저으 필요가 없는 경우에는 제거


DROP DATABASE IF EXISTS sqlDB;
CREATE DATABASE IF NOT EXISTS sqlDB;
USE sqldb;
CREATE TABLE userTble(
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height INT,
	mDate DATE
);

SHOW TABLES;
DESC userTble;
SHOW INDEX FROM userTble;
-- Non_unique : 0 중복불가 / 1 중복가능
-- Seq_in_index : 복합인덱스
-- CREATE INDEX (addr, height, mDate)
-- CREATE INDEX test_idx (user_id, mDate) FROM userTble;

-- WHERE user_id = 8 AND mDate = "2026-03-04"
-- Collation : 정렬 : Ascending : 오름 // D
-- Cardinality : 현재 세팅된 인덱스 안에 몇개의 값이 들어와있는가?

CREATE TABLE buyTble (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTble(userID)
);

SHOW INDEX FROM buyTble;

-- 데이터 검색 효율성

-- 최초에 테이블 생성 후 테이블 수정, 변경, 업데이트 > TLTER 명령어
/*
ALTER TABLE <Tablename> ADD COLUMN <추가할 컬럼명><추가할 컬럼 데이터형>
ALTER TABLE <Tablename> MODIFY COLUMN <변경할 컬럼명 (변경할 컬럼 데이터형)>
ALTER TABLE <Tablename> CHANGE COLUMN <기존컬럼명><변경할 컬럼 데이터형>
ALTER TABLE <Tablename> ADD CONSTRAINT TESTDatmDate Uniue(mDate)
ALTER TABLE <Tablename> ADD INDEX <인덱스이름>(컬럼명);
ALTER TABLE <Tablename> DROP INDEX <인덱스이름>
> 컬럼의 속성이 더이상 중복값을 x -> INDEX 처리
*/

ALTER TABLE userTble ADD CONSTRAINT TESTDate UNIQUE(mDate);

ALTER TABLE userTble ADD INDEX idx_addr(addr);

SHOW INDEX FROM userTble;

CREATE INDEX idx_name ON userTble(name);

-- PK // FK // ALTER UNIQUE() // CREATE INDEX

CREATE INDEX idx_group ON buyTble(groupName);
SHOW INDEX FROM buyTble;


DROP DATABASE IF EXISTS sqlDB;
CREATE DATABASE IF NOT EXISTS sqlDB;
USE sqlDB;
CREATE TABLE userTble(
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height INT,
	mDate DATE,
    -- INDEX idx_userTble_name (name),
    INDEX idx_userTble_addr (addr)
);

SHOW INDEX FROM userTble;

ALTER TABLE userTble DROP INDEX idx_userTble_addr;

CREATE DATABASE ecommerce;
USE ecommerce;
SHOW TABLES;
DESC product;
SELECT * FROM product;

USE ecommerce;
SELECT * FROM product;

DESC product;



