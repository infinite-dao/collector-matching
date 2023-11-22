# General improvements in the follow-up

- testing

    - test the reliability of the name assignment on data that has already been assigned and reviewed, false-positive testing on sample data
    - test `dwc_agent`: whether first names and call names entered in WikiData are also included in the name mapping result after standardisation with `dwc_agent`

- review and improve the code:

    - Include alternative names `skos:altLabel` <https://github.com/infinite-dao/collector-matching/issues/1#issuecomment-1819337177> from WikiData (resource)
    - compare name matching algorithm (<https://github.com/nielsklazenga/avh-collectors/cosine_similarity.ipynb> ⇌ `nearest_neighbour`)
    - Code improvements, ?kmeans optimisation https://github.com/sib-swiss/intermediate-python-training/blob/master/course2/01_resource_usage_measure_and_profiling.ipynb, also fine tuning (k-neighbour: Number of neighbors required for each sample by default for :meth:`kneighbors` queries (originally 5).)

- review life time matching

    - matching including `eventDate` (i.e. sampling date in this case; read https://www.gbif.org/data-quality-requirements-occurrences#dcEventDate)
    - floruit time span of person (almost no data)
    - recorded date of museum sample if no life data of the person are available ?occurrence.txt → eventDate? (see https://www.gbif.org/developer/occurrence section “Query parameters explained”

- review scoring/rating
- review DarwinCore attribution output (e.g. provided columns)


# Results (Done)

Provide a result table similar to the following one:

| gbifID    | identifier                              | action    | agentType | agentIdentifierType | occurrenceID                                 | startedAtTime | endedAtTime | verbatimName      | name                                  |
|-----------|-----------------------------------------|-----------|-----------|---------------------|----------------------------------------------|---------------|-------------|-------------------|---------------------------------------|
| 144827650 | http://www.wikidata.org/entity/Q65302   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100002788 | 1926-11-05    | 1926-11-05  | Troll,C.          | Carl Troll                            |
| 144827651 | http://www.wikidata.org/entity/Q5958231 | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100002790 | 1904-03-23    | 1904-03-23  | Fiebrig,K.        | Karl August Gustav Fiebrig            |
| 144827652 | http://www.wikidata.org/entity/Q65302   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100002791 | 1928-04-30    | 1928-04-30  | Troll,C.          | Carl Troll                            |
| 144827653 | http://www.wikidata.org/entity/Q2622975 | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100093156 | 1927-04-05    | 1927-04-05  | Eig,A.            | Alexander Eig                         |
| 144827665 | http://www.wikidata.org/entity/Q68637   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100217302 | 1917-08-14    | 1917-08-14  | Bornmüller,J.F.N. | Joseph Friedrich Nicolaus Bornmüller  |
| 144827667 | http://www.wikidata.org/entity/Q3030442 | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100217304 | 1918-01       | 1918-01     | Herter            | Wilhelm Gustav Franz Herter           |
| 144827668 | http://www.wikidata.org/entity/Q68637   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100217305 | 1918-06-22    | 1918-06-22  | Bornmüller,J.F.N. | Joseph Friedrich Nicolaus Bornmüller  |
| 144827670 | http://www.wikidata.org/entity/Q68637   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100217307 | 1917-07-23    | 1917-07-23  | Bornmüller,J.F.N. | Joseph Friedrich Nicolaus Bornmüller  |
| 144827673 | http://www.wikidata.org/entity/Q68637   | collected | Person    | wikidata            | https://herbarium.bgbm.org/object/B100217310 | 1932-06-07    | 1932-06-07  | Bornmüller,J.F.N. | Joseph Friedrich Nicolaus Bornmüller  |
 
For attribution see TDWG Attribution Interest Group, e.g. <https://github.com/tdwg/attribution/blob/master/documents/RDA_technical_examples.md>.


# Adding DarwinCore attribution CSV (almost Done)

- remove unnecessary CSV result if DarwinCore-attribution output is properly written
