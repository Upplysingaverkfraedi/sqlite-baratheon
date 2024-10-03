-- Create hlaup table
CREATE TABLE IF NOT EXISTS hlaup (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    upphaf TEXT,
    endir TEXT,
    nafn TEXT,
    fjoldi INTEGER,
    startadur INTEGER,
    lokadur INTEGER
);

-- Create timataka table
CREATE TABLE IF NOT EXISTS timataka (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hlaup_id INTEGER,
    bib INTEGER,
    nafn TEXT,
    timi TEXT,
    aldur TEXT,
    club TEXT,
    split TEXT,
    behind TEXT,
    chiptime TEXT,
    FOREIGN KEY (hlaup_id) REFERENCES hlaup(id)
);

-- Verify participant count matches
SELECT h.nafn, h.fjoldi, COUNT(t.id) AS participants
FROM hlaup h
LEFT JOIN timataka t ON h.id = t.hlaup_id
GROUP BY h.id
HAVING h.fjoldi != participants;
