-- 주석1 : 단문주석 -> SQL 표준주석 // Oracle
# 주석2 : 단문주석 -> MySQL 전용주석
/* 주석3 : 복문주석 */
-- 반드시 SQL 문법을 사용할 때에는 종료구문에 세미콜론(;)
-- 쿼리문을 작성해서 데이터베이스 & 테이블 생성, 편집, 삭제

/*
MySQL 접속 시, 이것부터 시작해라!

1. 데이터베이스 생성
CREATE DATABASE <dbname>;
> 데이터베이스의 이름 항상 직관, 명시적 -> 누가봐도 한 눈에 알아볼 수 있도록
> mysql -u root -p
> exit

CREATE DATABASE IF NOT EXISTS <dbname>;

CREATE DATABASE IF NOT EXISTS <dbname>
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

CREATE SCHEMA <dbname>;

UTF : Unicode Transformation Format
각 나라의 언어는 국제적으로 약속된 코드형식으로 이루어져있음

스크래피, 셀레니움, 파이썬 -> UTF8 -> 3byte
A = U+0041 : 1byte
가 = U+AC00 : 3byte
이모지 => 4byte

COLLATE => Collation

general_ci : case insensitive
general_cs : case sensitive

2. 현재 MySQL 안에 생성된 데이터베이스 조회
> SHOW DATABASES;

3. 데이터베이스 선택
> USE <dbname>;

4. 선택된 데이터베이스 안에 테이블 생성
> CREATE TABLE <tablename> (컬럼명 타입);
> CREATE TABLE IF NOT EXISTS <tablename> (컬럼명 타입);

5. 데이터베이스 안에 생성된 테이블 속성 조회
> DESC <tablename>;

6. 테이블 내부 값을 조회
> SELECT * FROM <tablename>

7. 생성된 테이블 안에 데이터 저장,삽입

8. 데이터베이스 삭제
> DROP DATABASE <dbname>
> DROP DATABASE IF EXISTS <dbname>;

ctrl + enter : 단문실행
ctrl + shift + enter : 복문실행

*/


-- create database

CREATE DATABASE digitalmkt;
CREATE DATABASE IF NOT EXISTS digitalmkt;
CREATE SCHEMA digitalmkt;

CREATE DATABASE IF NOT EXISTS digitalmkt
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

SHOW DATABASES;
USE digitalmkt;

DROP DATABASE digitalmkt;
DROP DATABASE IF EXISTS digitalmkt;





