USE instagram_review01;

DESC ig_tag_comments;

SELECT * FROM ig_tag_comments LIMIT 5;

-- 브랜드별 댓글 수 집계
SELECT brand, COUNT(*) AS comment_count
FROM ig_tag_comments
GROUP BY brand
ORDER BY comment_count DESC;

-- 브랜드별 게시글 작성자 수
SELECT brand, COUNT(DISTINCT author_id) AS unique_authors
FROM ig_tag_comments
GROUP BY brand
ORDER BY unique_authors DESC;

-- 게시물별 댓글수 상위 2개
SELECT brand, post_url, COUNT(*) AS comment_count
FROM ig_tag_comments
GROUP BY brand, post_url
ORDER BY comment_count DESC
LIMIT 5;

-- 특정 키워드 포함 댓글 찾기 (예뻐)
SELECT brand, comment_text
FROM ig_tag_comments
WHERE comment_text LIKE "%예뻐%"
	OR comment_text LIKE "%예뽀%"
	OR comment_text LIKE "%이쁘%";

SELECT brand, comment_text
FROM ig_tag_comments
WHERE comment_text REGEXP "예뻐|예뽀|이쁘|이뻐|예쁨";

SELECT brand, comment_text
FROM ig_tag_comments
WHERE comment_text REGEXP "예뻐|예뽀|이쁘|이뻐|예쁨";

SELECT brand, comment_text
FROM ig_tag_comments
WHERE comment_text REGEXP "예[뻐|뽀|쁘]|이[쁘|뻐]";

SELECT
	brand,
    COUNT(*) AS postitive_count,
	MIN(comment_text) AS sample_comment
FROM ig_tag_comments
WHERE comment_text REGEXP "예[뻐|뽀|쁘]|이[쁘|뻐]"
GROUP BY brand;

SELECT
	COUNT(*) AS total_comments,
    SUM(comment_text REGEXP "예[뻐|뽀|쁘]|이[쁘|뻐]") AS positive_count,
    ROUND(
		SUM(comment_text REGEXP "예[뻐|뽀|쁘]|이[쁘|뻐]") / COUNT(*) * 100,
        2
    ) AS potitive_ratio
FROM ig_tag_comments
WHERE brand = "에스피오나지";

-- 이모지 포함 댓글 수
SELECT COUNT(*) AS emoji_comments
FROM ig_tag_comments
WHERE comment_text REGEXP "[😀❤👍🔥]"





