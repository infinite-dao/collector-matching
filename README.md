# Matching of Collector Names to Other Resources

Tools to assist the name matching of (biological) collector names to other resources, like WikiData names and related IDs aso. This approach is based primarily on Niels Klazenga’s work from the Virtual Herbarium of Australia (☞ <https://github.com/nielsklazenga/avh-collectors/>).

If you have Jupyter Notebook and Python installed on your machine you can use or adapt the Notebook scripts to your needs more easily.

## Getting Data

- [`create_wikidata_datasets_botanists.ipynb`](./create_wikidata_datasets_botanists.ipynb) – to get data of botanists from WikiData
- [`create_bgbm_gbif-occurrence_collectors_dataset.ipynb`](./create_bgbm_gbif-occurrence_collectors_dataset.ipynb) – create an example data set from GIBF (*Virtual Herbarium Germany* (BGBM) <https://doi.org/10.15468/dl.tued2e>)

## Matching of Names

- [`match_names_BGBM-dwcagent-parsed_vs_WikiData.ipynb`](./match_names_BGBM-dwcagent-parsed_vs_WikiData.ipynb) – performing a name matching of parsed collector names (from own source data) to WikiData botanist names

## TODO

- review and improve the code:

    - test and improve name matching algorithm (<https://github.com/nielsklazenga/avh-collectors/cosine_similarity.ipynb>)
    
- add time matching as well

    - floruit time span of person
    - recorded date of museum sample if no life data of the person are available ?occurrence.txt → eventDate? (see https://www.gbif.org/developer/occurrence section “Query parameters explained”


