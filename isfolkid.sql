-- Hversu margar aðalpersónur eru í bókabálkinum?
WITH RECURSIVE split(characters, str) AS (
    SELECT
        '',
        characters || ','
    FROM
        books
    UNION ALL
    SELECT
        TRIM(SUBSTR(str, 0, INSTR(str, ','))),
        SUBSTR(str, INSTR(str, ',') + 1)
    FROM
        split
    WHERE
        str != ''
)
SELECT
    COUNT(DISTINCT characters)
FROM
    split
WHERE
    characters != '';


--Hversu margar persónur eru í hverri bók
SELECT
    is_title,
    LENGTH(characters) - LENGTH(REPLACE(characters, ',', '')) + 1
FROM books;

-- Hversu oft kemur Þengill fyrir í bókunum
WITH RECURSIVE split AS (
    SELECT
        TRIM(SUBSTR(characters, 1, INSTR(characters || ',', ',') - 1)) AS character,
        SUBSTR(characters, INSTR(characters || ',', ',') + 1) AS str
    FROM
        books
    WHERE
        characters IS NOT NULL
    UNION ALL
    SELECT
        TRIM(SUBSTR(str, 1, INSTR(str || ',', ',') - 1)),
        SUBSTR(str, INSTR(str || ',', ',') + 1)
    FROM split
    WHERE str != ''
)
SELECT
    COUNT(*) AS total_occurrences
FROM split
WHERE character = 'Þengill';


-- Hversu margir af Paladín ættinni
SELECT COUNT(*) FROM family WHERE name LIKE '%Paladín%';

-- Hversu algengur er illi arfurinn af þeim sem eru útvalin
SELECT COUNT(*) FROM family WHERE chosen_one='evil';

-- Hver er fæðingatíðni kvenna
SELECT birth, COUNT(*) AS total_females
FROM family
WHERE gender = 'F' AND birth IS NOT NULL
GROUP BY birth
ORDER BY birth ASC;

-- Hvað er Ísfólkið margar blaðsíður samanlagt?
SELECT SUM(pages) FROM books;

-- Hvað er meðallengd hvers þáttar af Ískisum?
SELECT AVG(length) FROM storytel_iskisur;
