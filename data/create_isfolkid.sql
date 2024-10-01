-- Búa til töflu fyrir bækur ef hún er ekki til
CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    pages INTEGER NOT NULL
);

-- Búa til töflu fyrir persónur ef hún er ekki til
CREATE TABLE IF NOT EXISTS characters (
    character_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    gender TEXT,
    birth_year INTEGER,
    family TEXT,
    evil_legacy INTEGER -- 1 ef persónan er með illan arf, 0 ef ekki
);

-- Búa til töflu sem tengir persónur við bækur ef hún er ekki til
CREATE TABLE IF NOT EXISTS appearances (
    appearance_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    character_id INTEGER,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id)
);

-- Búa til töflu fyrir Ískisur ef hún er ekki til
CREATE TABLE IF NOT EXISTS iskissur (
    episode_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    length_minutes INTEGER NOT NULL
);
