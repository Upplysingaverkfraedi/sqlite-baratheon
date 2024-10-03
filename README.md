## 2. Saga Ísfólksins

Til þess að keyra dæmi 2 þarf sqlite að vera hlaðið í tölvuna.
  - Fyrir macOS/linux: brew install sqlite
  - Fyrir window notanda: hlaðið inn SQLite frá síðunni: https://www.sqlite.org/download.html

Til þess að keyra dæmið þarf að byrja á því að keyra skipunina `sqlite3 data/isfolkid.db` í terminal
Þá er hægt að:
- sjá töflur sem að isfolkid inniheldur með því að keyra: `.tables` í terminal
- skoða innihald hverrar toflu með því að keyra `SELECT * FROM tafla(t.d. books)` í terminal

**Lausnir á spurningum**
Skráin `isfolkid.sql` inniheldur skipanir fyrir svörin við hverri spurningu, til þess að sjá svörin þarf að keyra `.read isfolkid.sql` í terminal


Verkefnið felur í sér að lesa inn SQLite gagnagrunninn [isfolkid.db](data/isfolkid.db) sem
inniheldur ýmis gögn um bókabálkinn _Söga Ísfólksins_ eftir norska rithöfundinn Margit Sandemo,
sem tröllreið íslenskt samfélag á 9. áratug 20. aldar.

1. Til að átta ykkur á grunninum, útbúið skipanaskrá sem sýnir hvernig gagnagrunninn er
   uppbyggður (ekki hafa gögnin sjálf með). Skilið henni sem `create_isfolkid.sql`.
2. Skilið skipanaskrá `isfolkid.sql` sem svarar eftirfarandi spurningum:
    - Hversu margar aðalpersónur eru í bókabálkinum?
    - Hversu margar persónur eru í hverri bók?
    - Hversu oft kemur Þengill fyrir í bókunum?
    - Hvað eru margir af Paladín ættinni?
    - Hversu algengur er illi arfurinn af þeim sem eru útvalin?
    - Hver er fæðingartíðni kvenna í bókabálkinum?
    - Hvað er Ísfólkið margar blaðsíður samanlagt?
    - Hvað er meðallengd hvers þáttar af _Ískisum_?

