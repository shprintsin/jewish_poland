
## Key Datasets

1. Final Data Files
   1. [`results/result_full.csv`](results/result_full.csv) - Main processed dataset containing tax payments, community locations and hierarchical relationships
   2. [`results/all_with_poviats.csv`](results/all_with_poviats.csv) - Dataset with assigned powiats (districts) for each settlement
   3. [`results/PinkasLitaSummery.pdf`](results/PinkasLitaSummery.pdf) - Summary of economic structure of Lithuanian Jewish communities
   4. [`results/סיווג נושאי - פנקס ליטא.xlsx`](results/TopicsFilter.xlsx) - Thematic classification of Lithuanian Pinkas topics records
   5. [`results/table_spis_census.csv`](results/table_spis_census.csv) - Processed version of 1765 census publication
   
2. Data Directory Contents
   1. Main Datasets
      1. [`data/jewishgen_features.csv`](data/jewishgen_features.csv) - Jewish communities database from JewishGen
      2. [`data/jg_fix.csv`](data/jg_fix.csv) - Fixes and corrections for JewishGen data
      3. [`data/kul_jewish.csv`](data/kul_jewish.csv) - Jewish data extracted from KUL atlas

   2. Jewish Professions Data [`data/jewish_professions/`](data/jewish_professions/)
      1. [`results.csv`](data/jewish_professions/results.csv) - Processed Bialystok census occupation data (1800)
      2. [`name_dict_full.csv`](data/jewish_professions/name_dict_full.csv) - Name classification by ethnicity (Jews, nobles, Poles, Germans)
      3. [`prf_dict.csv`](data/jewish_professions/prf_dict.csv) - Profession classifications
      4. Source files in [`source/`](data/jewish_professions/source/) - Multiple census years: 1779, 1810, 1825(a-f), 1843, 1852-1853

   3. Kalik Data [`data/kalik/`](data/kalik/)
      1. [`final.csv`](data/kalik/final.csv) - Processed tax registry data
      2. [`kalik_names.csv`](data/kalik/kalik_names.csv) - Standardized settlement names
      3. [`tables/`](data/kalik/tables/) - Original tables (1-14) with subtables

   4. KUL (Catholic University of Lublin) Data [`data/kul/`](data/kul/)
      1. [`latin_catholic_boundaries.csv`](data/kul/latin_catholic_boundaries.csv)
      2. [`latin_monasteries.csv`](data/kul/latin_monasteries.csv)
      3. [`sacral_objects.csv`](data/kul/sacral_objects.csv)
      4. GeoJSON files in [`geojson/`](data/kul/geojson/)

   5. Utility Data [`data/util/`](data/util/)
      1. [`jewish_towns.csv`](data/util/jewish_towns.csv) - Reference list of Jewish settlements

   6. Additional Resources
      1. [`data/geonames/`](data/geonames/) - Modern geographical reference data
      2. [`data/jewishgen/`](data/jewishgen/) - Additional JewishGen community data

## Poland Atlas Directory Contents

1. Core Data Files
   1. [`tax_registers_16c.csv`](poland_atlas/tax_registers_16c.csv) - Complete dataset of 16th century tax records

2. Economic Activity Data
   1. [`tavern_df.csv`](poland_atlas/tavern_df.csv) - Tavern lease data
   2. [`mill_df.csv`](poland_atlas/mill_df.csv) - Mill ownership and operations data
   3. [`tax_df.csv`](poland_atlas/tax_df.csv) - Tax sources and payments

3. Demographic and Economic Structure
   1. [`land_df.csv`](poland_atlas/land_df.csv) - Number of peasants, nobles, landowners by district
   2. [`workers_df.csv`](poland_atlas/workers_df.csv) - Professional occupations by category
   3. [`tenants_df.csv`](poland_atlas/tenants_df.csv) - Data on serfs and tenants
   4. [`animals_df.csv`](poland_atlas/animals_df.csv) - Livestock numbers by district

4. Processing Code
   1. [`tax_registers_main.r`](poland_atlas/tax_registers_main.r) - Main processing script for tax register data

5. Historical Borders [`borders_data/`](poland_atlas/borders_data/)
   1. Time series of administrative boundaries:
      1. [`v1500.json`](poland_atlas/borders_data/v1500.json)
      2. [`v1619.json`](poland_atlas/borders_data/v1619.json)
      3. [`v1772.json`](poland_atlas/borders_data/v1772.json)
      4. [`v1816.json`](poland_atlas/borders_data/v1816.json)
      5. [`v1830.json`](poland_atlas/borders_data/v1830.json)
      6. [`v1934.json`](poland_atlas/borders_data/v1934.json)
   2. Additional boundary data:
      1. [`Parafie.json`](poland_atlas/borders_data/Parafie.json) - Parish boundaries
      2. [`powiaty_1867.json`](poland_atlas/borders_data/powiaty_1867.json) - District boundaries
      3. [`general_gubeman_1943.json`](poland_atlas/borders_data/general_gubeman_1943.json)

6. Geospatial Data [`geojson/`](poland_atlas/geojson/)
   1. [`borders.geojson`](poland_atlas/geojson/borders.geojson) - General boundary data in GeoJSON format

7. Census and Registration Data
   1. [`1965cencusList.json`](primary_sources/1965cencusList.json) - JSON processing of Jewish population census
   2. [`table_spis_census.csv`](primary_sources/table_spis_census.csv) - 1765 census data
   3. [`table_spis_census_full.md`](primary_sources/table_spis_census_full.md) - Full text version preserving internal structure

8. Community Records
   1. [`PinkasVaadArbaAratsot.txt`](primary_sources/PinkasVaadArbaAratsot.txt) - Council of Four Lands records (OCR processed text, medium quality)
   2. [`pinkas_lita.docx`](primary_sources/pinkas_lita.docx), [`pinks_lita.csv`](primary_sources/pinks_lita.csv) - Lithuanian Council records
   3. [`PinkasLitaIndex.csv`](primary_sources/PinkasLitaIndex.csv) - Index of topics from Lithuanian community records

9. Legal Documents
   1. [`KahalCencelDecree.txt`](primary_sources/KahalCencelDecree.txt) - Decree abolishing Jewish self-government
   2. [`LegislationReardingJewsLithuania.txt`](primary_sources/LegislationReardingJewsLithuania.txt) - Legal documents about Jews in Lithuania
   3. [`ziemstwa.judaistyka.csv`](primary_sources/ziemstwa.judaistyka.csv)
   4. [`ziemstwa.judaistyka.json`](primary_sources/ziemstwa.judaistyka.json)
   5. [`ziemstwa.judaistykaPublication.html`](primary_sources/ziemstwa.judaistykaPublication.html) - Legal archives about Jewish communities

10. Books and Publications
    1. [`Yidn in amoliḳn Poyln.txt`](primary_sources/Yidn%20in%20amoliḳn%20Poyln.txt) - Original Yiddish text
    2. [`YidnInAmallicknPolandHeb.md`](primary_sources/YidnInAmallicknPolandHeb.md) - Hebrew translation using AI tools
    3. [`yidnInAmllickPoylin.txt`](primary_sources/yidnInAmllickPoylin.txt)

11. Reference Data
    1. [`HebrewBooks.csv`](primary_sources/HebrewBooks.csv) - Metadata from HebrewBooks archive
    2. [`jewishGen_communities.csv`](primary_sources/jewishGen_communities.csv)
    3. [`jewish_gen.json`](primary_sources/jewish_gen.json) - JewishGen community data

12. Additional Documents
    1. [`liczba-glow_o.pdf`](primary_sources/liczba-glow_o.pdf)
    2. [`spis-urzednikow-starej-warszawy-do-1501-1600.pdf`](primary_sources/spis-urzednikow-starej-warszawy-do-1501-1600.pdf) - List of Warsaw officials 1501-1600

13. External Resources
    1. [Atlas Fontium](https://atlasfontium.pl/)
    2. [Catholic University of Lublin Atlas](https://wiki.kul.pl/lhdb/Religie_i_wyznania_w_Koronie_w_II_po%C5%82owie_XVIII_wieku)
    3. [Jewish Self-Government Archives](https://ziemstwa.judaistyka.uj.edu.pl/)
    4. [Legal Status Project](https://statusprawnyzydow.historia.uw.edu.pl/)
    5. [Yiddish Book Center - "Yidn in amolikn Poyln"](https://www.yiddishbookcenter.org/collections/yiddish-books/spb-nybc208389/)
    6. [RCIN Digital Archive](https://rcin.org.pl/)
    7. [Jewish Galicia & Bukovina](https://jgaliciabukovina.net/he/node/57)
    8. [Tambora - Historical Climate Data](https://www.tambora.org/)
    9. [GeoNames](http://geonames.org)
    10. [OntoHGIS - Historical GIS Project](https://ontohgis.pl)
    11. [AGAD Archives](https://www.agad.gov.pl/inwentarze/testy.html)
    

<!--   

## Key Datasets

  

1. Final Data Files

	- [`results/result_full.csv`](results/result_full.csv) - Main processed dataset containing tax payments, community locations and hierarchical relationships
	
	- [`results/all_with_poviats.csv`](results/all_with_poviats.csv) - Dataset with assigned powiats (districts) for each settlement
	
	- [`results/PinkasLitaSummery.pdf`](results/PinkasLitaSummery.pdf) - Summary of economic structure of Lithuanian Jewish communities
	
	- [`results/סיווג נושאי - פנקס ליטא.xlsx`](results/סיווג%20נושאי%20-%20פנקס%20ליטא.xlsx) - Thematic classification of Lithuanian Pinkas topicsrecords
	
	- [`results/table_spis_census.csv`](results/table_spis_census.csv) - Processed version of 1765 census publication
2. Data Directory Contents

	1. Main Datasets

	- [`data/jewishgen_features.csv`](data/jewishgen_features.csv) - Jewish communities database from JewishGen
	
	- [`data/jg_fix.csv`](data/jg_fix.csv) - Fixes and corrections for JewishGen data
	
	- [`data/kul_jewish.csv`](data/kul_jewish.csv) - Jewish data extracted from KUL atlas

	2. Jewish Professions Data[`data/jewish_professions/`](data/jewish_professions/)
   - [`results.csv`](data/jewish_professions/results.csv)
   - Processed Bialystok census occupation data (1800)
   - [`name_dict_full.csv`](data/jewish_professions/name_dict_full.csv) - Name classification by ethnicity (Jews, nobles, Poles, Germans)
   - [`prf_dict.csv`](data/jewish_professions/prf_dict.csv) - Profession classifications
   - Source files in [`source/`](data/jewish_professions/source/) - Multiple census years: 1779, 1810, 1825(a-f), 1843, 1852-1853

   3. Kalik Data
      - [`data/kalik/`](data/kalik/)
      - [`final.csv`](data/kalik/final.csv) - Processed tax registry data
      - [`kalik_names.csv`](data/kalik/kalik_names.csv) - Standardized settlement names
      - [`tables/`](data/kalik/tables/) - Original tables (1-14) with subtables

   4. KUL (Catholic University of Lublin) Data
      - [`data/kul/`](data/kul/)
      - [`latin_catholic_boundaries.csv`](data/kul/latin_catholic_boundaries.csv)
      - [`latin_monasteries.csv`](data/kul/latin_monasteries.csv)
      - [`sacral_objects.csv`](data/kul/sacral_objects.csv)
      - GeoJSON files in [`geojson/`](data/kul/geojson/)

   5. Utility Data
   - [`data/util/`](data/util/)
   - [`jewish_towns.csv`](data/util/jewish_towns.csv)   - Reference list of Jewish settlements
  
   6. Additional Resources
   - [`data/geonames/`](data/geonames/) - Modern geographical reference data
   - [`data/jewishgen/`](data/jewishgen/) - Additional JewishGen community data

# Poland Atlas Directory Contents
## Core Data Files

- [`tax_registers_16c.csv`](poland_atlas/tax_registers_16c.csv)   - Complete dataset of 16th century tax records

## Economic Activity Data

- [`tavern_df.csv`](poland_atlas/tavern_df.csv) - Tavern lease data

- [`mill_df.csv`](poland_atlas/mill_df.csv) - Mill ownership and operations data

- [`tax_df.csv`](poland_atlas/tax_df.csv) - Tax sources and payments

  

## Demographic and Economic Structure

- [`land_df.csv`](poland_atlas/land_df.csv) - Number of peasants, nobles, landowners by district

- [`workers_df.csv`](poland_atlas/workers_df.csv)  - Professional occupations by category

- [`tenants_df.csv`](poland_atlas/tenants_df.csv) - Data on serfs and tenants

- [`animals_df.csv`](poland_atlas/animals_df.csv) - Livestock numbers by district

  

## Processing Code

- [`tax_registers_main.r`](poland_atlas/tax_registers_main.r) - Main processing script for tax register data

  

## Historical Borders

[`borders_data/`](poland_atlas/borders_data/)

- Time series of administrative boundaries:

  - [`v1500.json`](poland_atlas/borders_data/v1500.json)

  - [`v1619.json`](poland_atlas/borders_data/v1619.json)

  - [`v1772.json`](poland_atlas/borders_data/v1772.json)

  - [`v1816.json`](poland_atlas/borders_data/v1816.json)

  - [`v1830.json`](poland_atlas/borders_data/v1830.json)

  - [`v1934.json`](poland_atlas/borders_data/v1934.json)

- Additional boundary data:

  - [`Parafie.json`](poland_atlas/borders_data/Parafie.json) - Parish boundaries

  - [`powiaty_1867.json`](poland_atlas/borders_data/powiaty_1867.json) - District boundaries

  - [`general_gubeman_1943.json`](poland_atlas/borders_data/general_gubeman_1943.json)

  

## Geospatial Data

[`geojson/`](poland_atlas/geojson/)

- [`borders.geojson`](poland_atlas/geojson/borders.geojson)

  - General boundary data in GeoJSON format

  

## Census and Registration Data

- [`1965cencusList.json`](primary_sources/1965cencusList.json) - JSON processing of Jewish population census

- [`table_spis_census.csv`](primary_sources/table_spis_census.csv) - 1765 census data

- [`table_spis_census_full.md`](primary_sources/table_spis_census_full.md) - Full text version preserving internal structure

  

## Community Records

- [`PinkasVaadArbaAratsot.txt`](primary_sources/PinkasVaadArbaAratsot.txt)

  - Council of Four Lands records

  - OCR processed text, medium quality

- [`pinkas_lita.docx`](primary_sources/pinkas_lita.docx), [`pinks_lita.csv`](primary_sources/pinks_lita.csv)

  - Lithuanian Council records

- [`PinkasLitaIndex.csv`](primary_sources/PinkasLitaIndex.csv)

  - Index of topics from Lithuanian community records

  

## Legal Documents

- [`KahalCencelDecree.txt`](primary_sources/KahalCencelDecree.txt)

  - Decree abolishing Jewish self-government

- [`LegislationReardingJewsLithuania.txt`](primary_sources/LegislationReardingJewsLithuania.txt)

  - Legal documents about Jews in Lithuania

- [`ziemstwa.judaistyka.csv`](primary_sources/ziemstwa.judaistyka.csv)

- [`ziemstwa.judaistyka.json`](primary_sources/ziemstwa.judaistyka.json)

- [`ziemstwa.judaistykaPublication.html`](primary_sources/ziemstwa.judaistykaPublication.html) - Legal archives about Jewish communities

  

## Books and Publications

- [`Yidn in amoliḳn Poyln.txt`](primary_sources/Yidn%20in%20amoliḳn%20Poyln.txt) - Original Yiddish text

- [`YidnInAmallicknPolandHeb.md`](primary_sources/YidnInAmallicknPolandHeb.md) - Hebrew translation using AI tools

- [`yidnInAmllickPoylin.txt`](primary_sources/yidnInAmllickPoylin.txt)

  

## Reference Data

- [`HebrewBooks.csv`](primary_sources/HebrewBooks.csv) - Metadata from HebrewBooks archive

- [`jewishGen_communities.csv`](primary_sources/jewishGen_communities.csv)

- [`jewish_gen.json`](primary_sources/jewish_gen.json) - JewishGen community data

  

## Additional Documents

- [`liczba-glow_o.pdf`](primary_sources/liczba-glow_o.pdf)

- [`spis-urzednikow-starej-warszawy-do-1501-1600.pdf`](primary_sources/spis-urzednikow-starej-warszawy-do-1501-1600.pdf)

  - List of Warsaw officials 1501-1600

  

## Main Data

- [`result.csv`](result.csv) - Final processed dataset with Jewish community tax payments (1717-1764)

- [`data/kalik/tables/`](data/kalik/tables/) - Original source tables from Kalik's research

  

## Processing Code

- [`run.r`](run.r) - Main processing pipeline

- [`code/*.r`](code/) - Individual processing steps (data cleaning, normalization, geocoding)

  

## Geographic Data

- [`data/kul/geojson/`](data/kul/geojson/) - Spatial data from Catholic University of Lublin

  - [`sacral_objects.geojson`](data/kul/geojson/sacral_objects.geojson) - Religious buildings

  - [`catholic_boundaries.geojson`](data/kul/geojson/catholic_boundaries.geojson) - Administrative boundaries

- [`maps/PolandGeoJson/data/`](maps/PolandGeoJson/data/) - Modern Poland administrative boundaries

- [`maps/Atlas historyczny Polski XVI.json`](maps/Atlas%20historyczny%20Polski%20XVI.json) - 16th century Polish Atlas data

  

## Historical Sources

- [`primary_sources/`](primary_sources/)

  - [`YidnInAmallicknPolandHeb.md`](primary_sources/YidnInAmallicknPolandHeb.md) - Hebrew translation of "Yidn in amolikn Poyln"

  - [`PinkasVaadArbaAratsot.txt`](primary_sources/PinkasVaadArbaAratsot.txt) - Council of Four Lands records

  - [`pinkas_lita.csv`](primary_sources/pinkas_lita.csv) - Lithuanian Council records

  - [`table_spis_census.csv`](primary_sources/table_spis_census.csv) - 1765 Census data

  - [`KahalCencelDecree.txt`](primary_sources/KahalCencelDecree.txt) - Self-government cancellation decree

  

## Poland_atlas

- [`poland_atlas/`](poland_atlas/)

  - [`tax_registers_16c.csv`](poland_atlas/tax_registers_16c.csv) - 16th century tax registers

  - [`tavern_df.csv`](poland_atlas/tavern_df.csv), [`mill_df.csv`](poland_atlas/mill_df.csv) - Lease data

  - [`tax_df.csv`](poland_atlas/tax_df.csv) - Tax sources and payments

  

## Demographic Data

- [`data/jewish_professions/`](data/jewish_professions/)

  - [`results.csv`](data/jewish_professions/results.csv) - Processed occupation data from 1800 Bialystok census

  - [`name_dict_full.csv`](data/jewish_professions/name_dict_full.csv) - Name-ethnicity classification

  

## Reference Data

- [`data/jewishgen_features.csv`](data/jewishgen_features.csv) - JewishGen communities database

- [`links/bibliographyTitles.txt`](links/bibliographyTitles.txt) - Bibliography of Eastern European Jewish studies

- [`links/polin.txt`](links/polin.txt) - Polin journal publications

  

## External Resources

- [Atlas Fontium](https://atlasfontium.pl/)

- [Catholic University of Lublin Atlas](https://wiki.kul.pl/lhdb/Religie_i_wyznania_w_Koronie_w_II_po%C5%82owie_XVIII_wieku)

- [Jewish Self-Government Archives](https://ziemstwa.judaistyka.uj.edu.pl/)

- [Legal Status Project](https://statusprawnyzydow.historia.uw.edu.pl/)

- [Yiddish Book Center - "Yidn in amolikn Poyln"](https://www.yiddishbookcenter.org/collections/yiddish-books/spb-nybc208389/)

- [RCIN Digital Archive](https://rcin.org.pl/)

- [Jewish Galicia & Bukovina](https://jgaliciabukovina.net/he/node/57)

- [Tambora - Historical Climate Data](https://www.tambora.org/)

- [GeoNames](http://geonames.org)

- [OntoHGIS - Historical GIS Project](https://ontohgis.pl)

- [AGAD Archives](https://www.agad.gov.pl/inwentarze/testy.html) -->
