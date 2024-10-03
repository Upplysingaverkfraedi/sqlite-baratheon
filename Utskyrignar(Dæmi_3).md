Útskýring á RQL skjalinu


Búa til töfluna hlaup:
* CREATE TABLE IF NOT EXISTS hlup: Býr til töflu sem heitir hlaup ef hún er þegar ekki til.
* id INTEGER PRIMARY KEY AUTOINCREMENT: id er aðalskýringar (primary key) sem verður sjálfkrafa aukið fyrir hvern nýjan þáttakanda. Þetta tryggir að hver þátttakandi hefur einstakt auðkenni.
* upphaf DATETIME og endir DATETIME: upphaf og endir geyma dagsetningu og tíma sem tengist byrjun og endi hlaupsins.
* nafn TEXT: nafn geymdir nafn hlaupsins sem texta.
* fjoldi INTEGER: fjoldi geymir fjölda þátttakenda sem taka þátt í hlaupinu.
* startadur INTEGER og lokadur INTEGER: Geyma upplýsingar um staðsetningu (eða önnur töluleg gildi) sem tengjast hlaupi.

Búa til töfluna timataka:
* CREATE TABLE IF NOT EXISTS timataka: Býr til töflu sem heitir timataka ef hún er ekki þegar til.
* id INTEGER PRIMARY KEY AUTOINCREMENT: id er aðalskýringar sem verður sjálfkrafa aukið.
* hlaup_id INTEGER: hlaup_id er útlit á id í hlaup töflunni, sem tengir þátttakandann við tiltekið hlaup.
* bib INTEGER: bib geymir númer þátttakanda (t.d. númerið á keppnistímanum).
* nafn TEXT: nafn geymir nafn þátttakanda.
* timi TEXT: timi geymir tímann sem þátttakandi lauk hlaupi.
* aldur TEXT: aldur geymir aldur þátttakanda.
* club TEXT: club geymir upplýsingarnar um klúbbinn sem þátttakandi tilheyrir.
* split TEXT, behind TEXT, chiptime TEXT: Þessar dálkar geyma frekari upplýsingar um tímaskiptingu, eftir, og klukku-tíma.
* FOREIGN KEY (hlaup_id) REFERENCES hlaup(id): Þetta segir að hlaup_id í timataka tengist id í hlaup. Þetta tryggir að aðeins þátttakendur sem tengjast skráðri hlaupi séu leyfðir.

Skoða þátttakendafjölda:
* SELECT h.nafn, h.fjoldi, COUNT(t.id) AS participants: Velur nafn hlaups (h.nafn), fjölda þátttakenda (h.fjoldi), og fjölda þátttakenda sem hafa skráð sig í hlaup (COUNT(t.id)).
* FROM hlaup h: Velur gögnin úr hlaup töflunni og skýrir hana sem h.
* LEFT JOIN timataka t ON h.id = t.hlaup_id: Sameinar hlaup og timataka töflur þar sem hlaup_id í timataka samsvarar id í hlaup. LEFT JOIN tryggir að allar skráningar úr hlaup eru sýndar, jafnvel þótt engir þátttakendur séu skráðir í timataka.
* GROUP BY h.id: Skiptir niður gögnunum eftir hlaupi (h.id), svo að hægt sé að telja þátttakendur í hverju hlaupi.
* HAVING h.fjoldi != participants: Sýnir aðeins hlaupin þar sem fjöldi skráðra þátttakenda (frá timataka) er ekki sá sami og skráð fjöldi í hlaup.

Útksýring á REGEX

Upplýsingar um hlaupið:
* Start time\s*</small>\s*<h4>(.*?)<\/h4>:

* Start time: Leitar að textanum "Start time".
* \s*: Leyfir að vera hvaða fjöldi bil (whitespace) á eftir "Start time".
* </small>: Leitar að </small> HTML merkinu.
* \s*: Leyfir aftur bil á eftir.
* <h4>(.*?)<\/h4>: Leitar að tíma í <h4> merkinu. (.*?) er grípandi hópur sem dregur út tímann (start time) og leyfir hvaða fjölda af stöfum sem er á milli <h4> og </h4>.
* .*?Finished<\/small>\s*<h4>(\d+) / (\d+)<\/h4>:

* .*?: Leyfir hvaða fjölda af stöfum á milli fyrri og seinni hluta, en stoppar þegar "Finished" kemur.
* Finished<\/small>: Leitar að "Finished" og </small> merkinu.
* \s*<h4>(\d+) / (\d+)<\/h4>: Leitar að talnaskiptum í <h4> merki. (\d+) er grípandi hópur sem dregur út tölur (fjöldi þátttakenda sem byrjaði og lokið) á undan og á eftir "/".
* .*?Est\. finish time<\/small>\s*<h4>(.*?)<\/h4>:

* .*?: Leyfir aftur hvaða fjölda af stöfum.
* Est\. finish time<\/small>: Leitar að "Est. finish time" og </small> merkinu.
* \s*<h4>(.*?)<\/h4>: Leitar aftur að áætlaðra tímans í <h4> merki og dregur út ímann (end time) með (.*?).

Upplýsingar um hvern þátttakanda:

* <tr>: Leitar að byrjun á nýrri röð í HTML töflu.

* .*?<td class="hidden-xs">(\d+)</td>:

* .*?: Leyfir hvaða fjölda af stöfum áður en næsta merki kemur.
* <td class="hidden-xs">(\d+)</td>: Leitar að <td> merki sem hefur klasa "hidden-xs". (\d+) dregur út númer þátttakanda (rank).
* .*?<td>(\d+)</td>: Leitar að næsta <td> merki og dregur út bib númer þátttakanda.

* .*?<td>(.*?)<\/td>: Leitar að næsta <td> merki sem inniheldur nafn þátttakanda. (.*?) dregur út nafnið.

* .*?<td class="hidden-xs">(.*?)<\/td>: Leitar að næsta <td> merki með klasa "hidden-xs" og dregur út fæðingarár.

* .*?<td>(.*?)<\/td>: Leitar að næsta <td> merki og dregur út klúbbinn.

* .*?<td>(.*?)<\/td>: Leitar að næsta <td> merki og dregur út tímann (finish time) sem þátttakandi lauk á.