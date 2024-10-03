## Liður 2
### Create_isfolkid.sql
Þessi skrá sýnir hvernig gagnagrunnurinn isfolkid.db er uppbyggður án þess að nota hafa gögnin sjálf með.
Hér notuðum við skipunina`CREATE TABLE IF NOT EXISTS nafn á "nafnátöflu"` til þess að búa til hverja töflu. Hver tafla inniheldur dálka með mismunandi upplýsingum og kemur svo fram af hvaða gerð þær upplýsingar eru. Sem dæmi inniheldur línan `pages INTEGER`, í töflunni books, dálk með upplýsingum um blaðsíður bókanna og eru þær upplýsingar af gerðinni INTEGER, eða heiltölu.

### isfolkid.sql
Skipanaskráin isfolkid.sql svarar mismunandi spurningum út frá upplýsingum frá skránni `isfolkid.db`.

**Hversu margar aðalpersónur eru í bókabálkinum?**
`SELECT SUM(LENGTH(characters) - LENGTH(REPLACE(characters, ',', '')) + 1) AS total_main_characters` reiknar heildarfjölda persóna í dálkinum `characters` fyrir allar bækur í `books` töflunni með því að greina fjölda nafna sem eru aðskilin með kommum
**SVAR:**
102

**Hversu margar persónur eru í hverri bók?**
Skipunin telur fjölda persóna í hverri bók með því að reikna fjölda kommna í `characters` dálkinum, þar sem hver koma aðskildur hverja persónu. Hún skilar titli bókarinnar (`is_title`) ásamt fjölda persóna (`total_characters`) sem eru skráðar í characters dálknum.
**Svar:**
Álagafjötrar|2
Nornaveiðar|3
Hyldýpið|1
Vonin|1
Dauðasyndin|2
Illur arfur|3
Draugahöllin|1
Dóttir böðulsins|2
Skuggi fortíðar|2
Vetrarhríð|2
Blóðhefnd|3
Ástarfuni|2
Fótspor Satans|3
Síðasti riddarinn|2
Austanvindar|2
Gálgablómið|3
Garður dauðans|2
Gríman fellur|2
Tennur drekans|1
Hrafnsvængir|3
Um óttubil|3
Jómfrúin og vætturin|3
Vorfórn|4
Í iðrum jarðar|2
Guðsbarn eða galdranorn|3
Álagahúsið|1
Hneykslið|2
Ís og eldur|3
Ástir Lúcífers|3
Ókindin|6
Ferjumaðurinn|2
Hungur|2
Martröð|2
Konan á ströndinni|1
Myrkraverk|1
Galdratungl|4
Vágestur|2
Í skugga stríðsins|2
Raddirnar|2
Fangi tímans|3
Djöflafjallið|1
Úr launsátri|1
Í blíðu og stríðu|1
Skapadægur|1
Böðullinn|3
Svarta vatnið|1
Er einhver þarna úti?|1

**Hversu oft kemur Þengill fyrir í bókunum?**
`characters LIKE '%Þengill%'` Leitar í dálkinum characters eftir öllu sem inniheldur orðið "Þengill" og `COUNT(*)` Telur fjölda þeirra lína þar sem orðið "Þengill" kemur fyrir.
**Svar:**
2

**Hversu margir af Paladín ættinni?**
Skipunin `SELECT COUNT(*) FROM family WHERE name LIKE '%Paladín%';` er notuð til að telja hversu margir einstaklingar í family töflunni hafa "Paladín" í nafni sínu. `SELECT COUNT(*)` kallar á alla línurnar sem uppfylla skilyrðin og skilar heildarfjölda þeirra.
`FROM family` leitar í töflunni family og `WHERE name LIKE '%Paladín%'` leitar að nafni sem inniheldur "Paladín" hvar sem er í strengnum
**Svar:**
9

**Hversu algengur er illi arfurinn af þeim sem eru útvalin?**
`SELECT COUNT(*) FROM family WHERE chosen_one='evil'`
`SELECT COUNT(*)` kallar á allar línurnar sem uppfylla skilyrðin og skilar heildarfjölda þeirra,
`FROM family` leitar í töflunni family og `WHERE chosen_one='evil'` finnur þá einstaklinga sem hafa gildið 'evil' í dálknum chosen_one
**Svar:**
18

**Hver er fæðingatíðni kvenna?**
Skipunin `SELECT birth, COUNT(*) AS total_females FROM family WHERE gender = 'F' AND birth IS NOT NULL GROUP BY birth ORDER BY birth ASC;` er notuð til að finna fæðingatíðni kvenna í `family` töflunni. `GROUP BY birth` skiptir niðurstöðunum eftir fæðingarárinu, þannig að fjöldi kvenna í hverju ári sé talinn saman og `ORDER BY birth ASC` raðar niðurstöðunum í hækkandi röð eftir fæðingarárinu
**Svar:**
1556|1
1564|1
1579|1
1583|1
1587|1
1601|2
1602|1
1610|1
1616|1
1627|1
1628|1
1629|1
1634|1
1638|1
1652|1
1655|1
1656|1
1674|1
1677|1
1678|1
1679|1
1694|1
1697|1
1698|1
1699|1
1716|1
1720|1
1750|1
1752|1
1769|1
1775|1
1777|1
1779|1
1788|1
1796|1
1800|2
1820|1
1825|1
1829|1
1830|1
1836|1
1842|1
1848|1
1853|1
1855|1
1872|2
1880|1
1884|1
1894|1
1902|1
1909|1
1910|1
1922|1
1926|1
1929|1
1937|1
1938|1
1942|1
1943|1
1948|1

**Hvað er Ísfólkið margar blaðsíður samanlagt?**
`SELECT SUM(pages) FROM books;`
`SELECT SUM(pages)` sækir summu allra gilda í dálkinum pages `FROM books` Þetta segir að notar gögn úr töflunni books
**Svar:**
8023

**Hvað er meðallengd hvers þáttar af Ískisum?**
`SELECT AVG(length)` sækir meðaltal allra gilda í dálkinum length og `FROM storytel_iskisur` sækir gögnin úr töflunni storytel_iskisur+
**Svar:**
116.40206185567