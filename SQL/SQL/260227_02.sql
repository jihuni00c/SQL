CREATE DATABASE IF NOT EXISTS sqlDB;

USE sqlDB;

-- index : 색인 // 책 뒤쪽에 word : 125, apple : 310
-- userTbl 저장된 데이터가 10만건, 1사람 -> 10만번 데이터 // 한번 자동검색기능
-- 클러스터형 인덱스 // 보조 인덱스 
-- 해당 인덱스 불필요해질 수 있음 -> 제거

CREATE TABLE userTbl (
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(3),
    height SMALLINT,
    mDate DATE,
    INDEX idx_userTbl_name (name),
    INDEX idx_userTbl_addr (addr)
);

CREATE TABLE buyTbl (
	num INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES userTbl(userId)
);

-- FOREIGN KEY 설정해놓기 않아도 서로 다른 테이블간 JOIN
-- KEY > 인덱싱, 그룹설정 조건값 키 + 외부테이블 연결 매개체
-- 만약 양쪽 외래키 존재 x, JOIN -> 두 테이블에 동일한 키가 없었음에도 JOIN -> NULL
-- 에러 x, 없어서 안되었나보다
-- FOREIGN KEY -> 에러!!! (참조할 수 있는 값x)

SHOW TABLES;

DESC buyTbl;
DESC userTbl;

INSERT INTO userTbl VALUES ("HGD", "홍길동", 2000, "서울", "010", "123", 180, "2000-10-1");
INSERT INTO buyTbl VALUES (DEFAULT, "HGD", "조깅화", "신발", 10, 2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

DELETE FROM userTbl WHERE userId = "HGD";




