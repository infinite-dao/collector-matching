A collection of tools.

`agent_parse4tsv.rb` — parses tabulator separated files and needs <https://libraries.io/rubygems/dwc_agent> to be installed.


## Parsing of Name Lists

Often you have multiple names in a list and want to separate them. For this you can use the Ruby gem package <https://libraries.io/rubygems/dwc_agent>

```bash
ruby agent_parse4tsv.rb --help # show help and usage

# if you have a tabulator separated data file containing column headers and in the 1st column the name lists, then try something like:
ruby agent_parse4tsv.rb \
  --input ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv

# or check also running time of the parsing script with `time command`
time ruby agent_parse4tsv.rb \
  --input ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv
# real    5m2,451s
# user    2m38,644s
# sys     2m4,709s
```
