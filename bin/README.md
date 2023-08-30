A collection of tools.

`agent_parse4tsv.rb` — parses tabulator separated files and needs <https://libraries.io/rubygems/dwc_agent> to be installed.


## Parsing of Name Lists

Often you have multiple names in a list and want to separate them. For this you can use the Ruby gem package <https://libraries.io/rubygems/dwc_agent>

`agent_parse4tsv.rb` parses names and skippes empty parsing results by default. For analysing name parsing you can use options `--logfile` or/and `--develop`, explained in the help text messages:

```bash
ruby agent_parse4tsv.rb --help # show help and usage

# if you have a tabulator separated data file containing column headers and in the 1st column the name lists, then try something like:
ruby agent_parse4tsv.rb \
  --input  ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv

# or check also running time of the parsing script with `time command`
time ruby agent_parse4tsv.rb \
  --input  ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv
  # real    5m2,451s
  # user    2m38,644s
  # sys     2m4,709s
```

You can use `--logfile` to get a list of skipped names as well (here in combination of measuring the script time):

```bash
time ruby agent_parse4tsv.rb --logfile \
  --input  ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830.tsv \
  --output ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv
  # -------------------------
  # Done.
  # We have 64381 empty parsing results detected.
  #   You can also use --develop to get a full result table including the used source data of each parsed line
  # Wrote log file of skipped names to
  #   ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv.log
  # Wrote data to
  #   ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv
  # -------------------------
  # real    1m17,880s
  # user    0m40,357s
  # sys     0m24,719s
```
