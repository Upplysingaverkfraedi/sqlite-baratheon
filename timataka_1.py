import re
import requests
import sqlite3
import argparse
import csv
from tabulate import tabulate

# Define regex patterns for race and participant extraction
race_info_regex = r'Start time\s*</small>\s*<h4>(.*?)<\/h4>.*?Finished<\/small>\s*<h4>(\d+) / (\d+)<\/h4>.*?Est\. finish time<\/small>\s*<h4>(.*?)<\/h4>'
participant_regex = r'<tr>.*?<td class="hidden-xs">(\d+)</td>.*?<td>(\d+)</td>.*?<td>(.*?)<\/td>.*?<td class="hidden-xs">(.*?)<\/td>.*?<td>(.*?)<\/td>.*?<td>(.*?)<\/td>'

# Set up SQLite database connection
conn = sqlite3.connect('timataka.db')
cursor = conn.cursor()

# Create tables if not already present
cursor.execute('''
    CREATE TABLE IF NOT EXISTS hlaup (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        upphaf TEXT,
        endir TEXT,
        nafn TEXT,
        fjoldi INTEGER,
        startadur INTEGER,
        lokadur INTEGER
    )
''')

cursor.execute('''
    CREATE TABLE IF NOT EXISTS timataka (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hlaup_id INTEGER,
        bib INTEGER,
        nafn TEXT,
        timi TEXT,
        aldur TEXT,
        club TEXT,
        split TEXT,
        chiptime TEXT,
        FOREIGN KEY (hlaup_id) REFERENCES hlaup(id)
    )
''')

# Function to export data into a CSV file
def export_to_csv():
    cursor.execute("SELECT * FROM timataka")
    rows = cursor.fetchall()

    # Define the CSV file structure
    with open('timataka_results.csv', mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['id', 'hlaup_id', 'bib', 'nafn', 'timi', 'aldur', 'club', 'split', 'chiptime'])
        writer.writerows(rows)
    print("Results successfully exported to timataka_results.csv")

# Read URLs from file
with open('agust_2024.txt', 'r', encoding='utf-8') as f:
    urls = [line.strip() for line in f if line.startswith('http')]

for url in urls:
    print(f"Fetching data from {url}")
    
    # Fetch HTML content
    response = requests.get(url)
    html_content = response.text
    
    # Extract race information
    race_match = re.search(race_info_regex, html_content, re.DOTALL)
    if race_match:
        start_time, started, finished, end_time = race_match.groups()
        race_name = re.search(r'<h2>(.*?)<\/h2>', html_content).group(1)
        
        # Insert race data into `hlaup` table
        cursor.execute('''
            INSERT INTO hlaup (upphaf, endir, nafn, fjoldi, startadur, lokadur)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (start_time, end_time, race_name, finished, started, finished))
        hlaup_id = cursor.lastrowid

        # Extract participant data
        participants = re.findall(participant_regex, html_content, re.DOTALL)
        for participant in participants:
            rank, bib, name, birth_year, club, finish_time = participant
            chiptime_match = re.search(r'Chiptime</td>.*?<td>(.*?)<\/td>', html_content, re.DOTALL)
            chiptime = chiptime_match.group(1) if chiptime_match else ""
            splits = re.findall(r'<br>(.*?)</td>', html_content)

            cursor.execute('''
                INSERT INTO timataka (hlaup_id, bib, nafn, timi, aldur, club, split, chiptime)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ''', (hlaup_id, bib, name, finish_time, birth_year, club, '\n'.join(splits), chiptime))
        
        conn.commit()
        print(f"Race data for {race_name} inserted successfully.")
    else:
        print(f"Failed to parse race data for {url}")

# Export results to CSV
export_to_csv()

# Verify if participant count matches race records
cursor.execute('''
    SELECT hlaup.nafn, hlaup.fjoldi, COUNT(timataka.id) 
    FROM hlaup 
    JOIN timataka ON hlaup.id = timataka.hlaup_id 
    GROUP BY hlaup.id
''')

race_verification = cursor.fetchall()
for race in race_verification:
    race_name, expected_count, actual_count = race
    if expected_count != actual_count:
        print(f"Mismatch in {race_name}: expected {expected_count}, but found {actual_count} participants.")
    else:
        print(f"{race_name}: Participant count verified.")

# Close the database connection
conn.close()
