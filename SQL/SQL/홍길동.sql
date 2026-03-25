DROP DATABASE IF EXISTS school;

CREATE DATABASE IF NOT EXISTS school;

USE school;

CREATE TABLE students (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT UNSIGNED,
    grade VARCHAR(10)
);

DESC students;

INSERT INTO stuents VALUES(1, "홍길동", 15, "9학년");
INSERT INTO stuents VALUES(DEFAULT, "고길동", 16, "10학년");
INSERT INTO stuents (name, age, grade) VALUES(1, "신길동", 17, "11학년");

SELECT * FROM students;

TRUNCATE TABLE students;

INSERT INTO students (grade, name, age)
VALUES
	("9학년", "홍길동", 15),
    ("10학년", "고길동", 16),
    ("11학년", "신길동", 17);

DESC students;

-- 속성
ALTER TABLE students
	MODIFY age INT UNSIGNED NOT NULL,
    MODIFY grade VARCHAR(10) NOT NULL;

ALTER TABLE students
	MODIFY age INT UNSIGNED;

-- 값 / 초심자들의 가장 큰 실수
UPDATE students
SET grade = "12학년", age = 18
WHERE id = 3;
-- WHERE grade = "11학년" AND age = 17;

SET SQL_SAFE_UPDATES = 0;

UPDATE students
SET grade = "11학년", age = 17
WHERE grade = "12학년" AND age = 18;

SET SQL_SAFE_UPDATES = 1;

INSERT INTO stuents (name, age, grade) VALUES("이길동", 14, "8학년");

SELECT * FROM students;

SELECT
	name, age
FROM students;

-- 조건은 where
SELECT *
FROM students
WHERE age = 16;

-- 프로그래밍언어 : == | ===

SELECT *
FROM students
WHERE age <> 16;

SELECT *
FROM students
WHERE age > 16;

SELECT *
FROM students
WHERE age < 16;

SELECT *
FROM students
WHERE age >= 16;

SELECT *
FROM students
WHERE age <= 16;

SELECT *
FROM students
WHERE age != 16;

INSERT INTO stuents (name, age, grade) VALUES("길동", NULL, "9학년");

SELECT * FROM students;

SELECT * FROM students WHERE age <> 16;
SELECT * FROM students WHERE age != 16;
-- 부정연산자 종류 : Null 배제

SELECT * FROM students WHERE age IS NOT NULL



