# Matching of Collector Names to Other Resources

Here we gathered tools to assist the name matching of (biological) collector names to other resources, like WikiData names and related IDs aso. This approach is based primarily on Niels Klazenga’s work from the Virtual Herbarium of Australia (☞ <https://github.com/nielsklazenga/avh-collectors/>), thank you for that ;-)

*What you need first:* 
- You need to know programming or at least code programming understanding to use these tools. 
- If you have Jupyter Notebook and Python installed on your machine you can use or adapt the Notebook scripts to your needs more easily.

Steps in general:

1. Getting Data (source names)
    
    - construct or prepare collector name data
    - parse names with dwcagent, i.e. standardization of given verbatim name lists into individual names

2. Getting Data (resource names)

    - get name lists with public person identifiers from WikiData (also other SPARQL resources would do)
    
3. Matching of Names

    - do matching and comparison of fragmentated name parts (n-grams) using k-nearest neighbour or cos similarity
    - write table data output (e.g. CSV) according to DarwinCore Agent Attribution (GitHub: [RDA_recommendations.md](https://github.com/tdwg/attribution/blob/master/documents/RDA_recommendations.md), [RDA_technical_examples.md](https://github.com/tdwg/attribution/blob/master/documents/RDA_technical_examples.md)) to faciliate post processing
    

## Getting Data

Get or construct *source* names, i.e. collector name lists—see the following examples.

BGBM example:
- [`create_bgbm_gbif-occurrence_collectors_dataset.ipynb`](./create_bgbm_gbif-occurrence_collectors_dataset.ipynb)—create an example data set from GIBF (*Virtual Herbarium Germany* (BGBM) <https://doi.org/10.15468/dl.tued2e>)
- [`create_bgbm_gbif-occurrence_collectors_eventDate_dataset.ipynb`](./create_bgbm_gbif-occurrence_collectors_eventDate_dataset.ipynb)—create an example data set with collection date (`eventDate`) from GIBF (*Virtual Herbarium Germany* (BGBM) <https://doi.org/10.15468/dl.tued2e>)

Meise example:
- [`create_meise_gbif-occurrence_collectors_eventDate_dataset.ipynb`](./create_meise_gbif-occurrence_collectors_eventDate_dataset.ipynb)—create an example data set with collection date (`eventDate`) from GIBF (*Meise Botanic Garden Herbarium* <https://doi.org/10.15468/dl.ax9zkh>)

Naturalis example:
- [`create_naturalis_gbif-occurrence_collectors_eventDate_dataset.ipynb`](./create_naturalis_gbif-occurrence_collectors_eventDate_dataset.ipynb)—create an example data set with collection date (`eventDate`) from GIBF (*Naturalis Biodiversity Center (NL) - Botany* <https://doi.org/10.15468/dl.uw8rxk>)

Plazi example:
- [`create_plazi_collectors_dataset.ipynb`](./create_plazi_collectors_dataset.ipynb)—create only data from Plazi‘s Collection Statistics “Materials Citation Data” (<https://tb.plazi.org/GgServer/srsStats>)

---

Get *resource* names of WikiData to compare collector *source* names with:

- [`create_wikidata_datasets_botanists.ipynb`](./create_wikidata_datasets_botanists.ipynb)—to get data of botanists from WikiData

## Parsing of Name Lists

See ☞ [`bin/README.md`](./bin/README.md).


## Matching of Names

BGBM examples:

- [`match_names_BGBM-dwcagent-parsed_vs_WikiData_k-nearest.ipynb`](./match_names_BGBM-dwcagent-parsed_vs_WikiData_k-nearest.ipynb)—performing a name matching of parsed collector names (from own source data) to WikiData botanist names
- [`match_names_BGBM-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb`](./match_names_BGBM-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb)—performing a name matching of parsed collector names including eventDate (=date of sampling event)
- [`match_names_BGBM-dwcagent-parsed_vs_WikiData_cosine-similarity.ipynb`](./match_names_BGBM-dwcagent-parsed_vs_WikiData_cosine-similarity.ipynb)—performing a name matching using cosine-similarity of parsed collector names (from own source data) to WikiData botanist names

Meise examples:

- [`match_names_Meise-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb`](./match_names_Meise-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb)—performing a name matching of parsed collector names including eventDate (=date of sampling event)
- [`match_names_Meise-dwcagent-parsed-eventDate_vs_WikiData_cosine-similarity.ipynb`](./match_names_Meise-dwcagent-parsed-eventDate_vs_WikiData_cosine-similarity.ipynb)—performing a name matching using cosine-similarity of parsed collector names (from own source data) to WikiData botanist names including eventDate (=date of sampling event)

Naturalis examples:

- [`match_names_Naturalis-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb`](./match_names_Naturalis-dwcagent-parsed-eventDate_vs_WikiData_k-nearest.ipynb)—performing a name matching of parsed collector names including eventDate (=date of sampling event)
- [`match_names_Naturalis-dwcagent-parsed-eventDate_vs_WikiData_cosine-similarity.ipynb`](./match_names_Naturalis-dwcagent-parsed-eventDate_vs_WikiData_cosine-similarity.ipynb)—performing a name matching using cosine-similarity of parsed collector names (from own source data) to WikiData botanist names including eventDate (=date of sampling event)

Plazi example:

- [`create_and_match_plazi_collectors_dataset.ipynb`](./create_and_match_plazi_collectors_dataset.ipynb)—create and match data from Plazi‘s Collection Statistics “Materials Citation Data” (<https://tb.plazi.org/GgServer/srsStats>)


## TODO and Review

- review and improve the code:

    - compare name matching algorithm (<https://github.com/nielsklazenga/avh-collectors/cosine_similarity.ipynb> ⇌ `nearest_neighbour`)

- improve name matching if own source data contain a full name, this can be matched against WikiData (perhaps parsed) `itemLabel`, which is mostly the full name

- add other example data sets: Meise, Naturalis
- add time matching as well

    - matching including `eventDate` (i.e. sampling date in this case; read https://www.gbif.org/data-quality-requirements-occurrences#dcEventDate)
    - floruit time span of person
    - recorded date of museum sample if no life data of the person are available ?occurrence.txt → eventDate? (see https://www.gbif.org/developer/occurrence section “Query parameters explained”

- add a conclusion of matching results and/or comparison or a short summary (the important points)
