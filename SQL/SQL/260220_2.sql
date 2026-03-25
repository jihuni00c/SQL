-- 테이블 생성 

/*
1) 테이블 생성 시, 2가지 방법alter

CREATE TABLE <tablename> ();
CREATE TABLE IF NOT EXISTS <tablename> ();
테이블 생성 시, () 안에 입력될 요소들이 바로 스키마 (약속된 타입 정의)
컬럼을 몇 개 만들 것이고, 각 컬럼 내부에 입력될 값들이 어떤 타입으로 채워지게 할 것인가를 사전에 약속, 정의

DROP TABLE <tablename>;
DROP TABLE IF EXISTS <tablename>;
*/

CREATE TABLE IF NOT EXISTS digitalclass (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
	PRIMARY KEY(id)
);

DESC digitalclass;

SELECT * FROM digitalclass;

DROP TABLE IF EXISTS digitalclass;

CREATE TABLE IF NOT EXISTS mktclass (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    modelnumber VARCHAR(15) NOT NULL,
    series VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);

DESC mktclass;

SELECT * FROM mktclass;


/*


*/