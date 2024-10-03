-- notast var við sqlite> .schema til að fá neðangreindar töflur

CREATE TABLE IF NOT EXISTS books (
    id INTEGER PRIMARY KEY,
    is_title TEXT,
    no_title TEXT,
    se_title TEXT,
    year INTEGER,
    is_year INTEGER,
    is_release DATE,
    pages INTEGER,
    chapters INTEGER,
    translator TEXT,
    characters TEXT,
    est_publication DATE
);

CREATE TABLE IF NOT EXISTS alvarpid (
    id INTEGER PRIMARY KEY,
    book TEXT,
    episode_title TEXT,
    length INTEGER,
    listeners INTEGER,
    release DATE
);

CREATE TABLE IF NOT EXISTS family(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    death INTEGER,
    mom INTEGER REFERENCES family(id),
    dad INTEGER REFERENCES family(id),
    gender CHAR(1),
    birth TINYINT,
    chosen_one BOOLEAN
);

CREATE TABLE IF NOT EXISTS marriage (
    female INTEGER REFERENCES family(id),
    male INTEGER REFERENCES family(id),
    remark BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS storytel_isfolkid (
    id INTEGER PRIMARY KEY,
    is_title TEXT,
    reader TEXT,
    reviews INTEGER,
    rating REAL,
    length INTEGER,
    audiobook DATE,
    ebook DATE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS storytel_iskisur(
    episode INTEGER,
    part INTEGER,
    reviews INTEGER,
    rating REAL,
    release DATE,
    description TEXT,
    PRIMARY KEY (episode, part)
);

CREATE TABLE IF NOT EXISTS special_events(
    date DATE,
    event TEXT,
    enddate DATE,
    remark TEXT
);

CREATE TABLE IF NOT EXISTS children(
    parent INTEGER REFERENCES family(id) NOT NULL,
    child INTEGER REFERENCES family(id) NOT NULL,
    PRIMARY KEY(parent, child)
);
