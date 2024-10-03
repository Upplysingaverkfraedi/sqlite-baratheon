-- Hversu margar aðalpersónur eru í bókabálkinum?
SELECT SUM(LENGTH(characters) - LENGTH(REPLACE(characters, ',', '')) + 1) AS total_main_characters
FROM books
WHERE characters IS NOT NULL;

--Hversu margar persónur eru í hverri bók
SELECT
    is_title,
    LENGTH(characters) - LENGTH(REPLACE(characters, ',', '')) + 1
FROM books;

-- Hversu oft kemur Þengill fyrir í bókunum
SELECT COUNT(*) AS total_occurrences
FROM books
WHERE characters LIKE '%Þengill%';

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
