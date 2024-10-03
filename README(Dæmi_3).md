## 3. Gagnagrunnur fyrir tímataka.net

Til að geta keyrt timataka_1.py þarf að fara í terminal og keyra skipunina:
`python timataka_1.py --file agust_2024.txt`

Svo til að geta keryt sql skjalið þarf að downloada sqlite3 pakkanum, það er gert með skipuninni:
`pip install sqlite3`

Til að opna sqlite3 er keyrt skipunina:
`sqlite3 timataka.db`

Til að geta séð töflurnar í sql skránni er keyrt:
`.tables`

Svo til að geta séð hvað er inn í töflunum er keyrt:
`SELECT * FROM hlaup` og `SELECT * FROM timataka`

Nú skal vinna áfram með tímatöku-liðinn sem var kynntur í
[síðasta hópverkefni](https://github.com/Upplysingaverkfraedi/regex/?tab=readme-ov-file#4-gagna%C3%BArvinnsla).

Sérhver hópur fær ákveðið tímabil og skal taka saman öll hlaup úr þeim mánuði og skila sem
SQLite gagnagrunn:

1. Baratheon - ágúst 2024
2. Greyjoy - ágúst 2023
3. Lannister - ágúst 2022
4. Martell - ágúst 2021
5. Stark - ágúst 2020
6. Targaryen - ágúst 2019
7. Tyrell - ágúst 2018

### SQLite3 gagnagrunnur

Gagnagrunnurinn skal hafa eftirfarandi töflur:

1. Taflan `hlaup` sem tekur saman helstu upplýsingar um sérhvert hlaup, t.d.:
    - `id`: Auðkenni
    - `upphaf`: Tímasetning hlaups (dagsetning og tími dags)
    - `endir`: Áætluð lok hlaups (dagsetning og tími dags)
    - `nafn`: Nafn hlaups
    - `fjoldi`: Fjöldi þátttakenda
    - og fleiri eftir þörfum.
2. Taflan `timataka` sem tekur saman upplýsingar um hvern þátttakanda í hlaupinu, þar ætti að koma
   fram:
    - `id`: Auðkenni
    - `hlaup_id`: Auðkenni hlaups (ytri lykill)
    - `nafn`: Nafn keppanda
    - `timi`: Tími sem keppandi lauk hlaupinu á
    - `kyn`: Kyn keppanda (ef uppgefið)
    - `aldur`: Aldur keppanda (ef uppgefið)
    - og fleiri eftir þörfum.

Sannreynið með samsöfnun og hópun hvort fjöldi keppanda í `hlaup` töflunni sé réttur út frá
fjölda lína í `timataka` töflunni.

Skilið skipanaskrá `timataka.sql` sem býr til gagnagrunninn, les gögnin inn og sannreynir fjölda.

> Þið viljið ekki tvítaka gögn, t.d. í tilfelli Flensborgarhlaupið 2024 þá er ýmist gefið upp  
> [heildar](https://timataka.net/flensborgarhlaup2024/urslit/?race=2&cat=overall) niðurstöður,
> og líka niðurbrotið á [karla](https://timataka.net/flensborgarhlaup2024/urslit/?race=2&cat=m) og
> [kvenna](https://timataka.net/flensborgarhlaup2024/urslit/?race=2&cat=f) sér. Grunnurinn skal
> passa að það verða ekki leyfðar tvítekningar. Passið samt að þið missið ekki upplýsingar
> einsog kyn og aldur.

### RegEx útvíkkun

1. Útvíkkið Python kóðann ykkar `code/timataka.py` þannig að hann getur tekið lesið og unnið
   fleiri hlaup. Kóðinn skal vera **almennur**, ekki bundinn við ákveðin tímabil eða tegund
   hlaups. Passið að þið harðkóðið ekki nöfn hlaupa eða keppenda í kóðanum.
2. **Ábending**, hér gæti verið gott að brjóta upp reglulegu segðina frá því síðast í tvær
   reglulegar segðir:
    1. Eina til að finna viðeigandi línu (`thead` fyrir dálkaheiti og `tr` fyrir tímatöku gögn).
    2. Svo þegar við erum búin að finna viðeigandi línu, notið aðra reglulega segð
       til að finna gildin úr öllum dálkum (`td`).
3. Bætið við reglulega segð til að sækja öll viðbótarupplýsingar sem á almennt við hlaupið.

### Samvinna

Mælt er með að tveir nemendur vinni saman að þessum liði. Annar nemandi einbeitir sér að því að
parsa gögnin með uppfærðu RegEx í Python, meðan hinn býr til gagnagrunninn og innlestur gagna.

Þið þurfið ekki að bíða eftir RegEx hlutnum til að hefja vinnu með SQLite gagnagrunninn, þar sem
niðurstöður frá síðasta verkefni eru til staðar.

Ekki er mælt með að þið vinni í sama branchi.

Nauðsynlegt er að vinna náið saman svo hægt sé að uppfæra SQLite gagnagrunninn með nýjustu gögnunum.
Hugsanlega væri gott að búa til branch fyrir RegEx hlutann sem er tengdur við SQLite, og gera PR í
SQLite branchið til að tryggja að það sé alltaf uppfært. Þaðan má svo gera PR í main branchið.
