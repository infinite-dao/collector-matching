
A collection of tools:

- `agent_parse4tsv.rb` — parses names of tabulator separated values and needs <https://libraries.io/rubygems/dwc_agent> to be installed (usually with `gem install dwc_agent`, see also [github.com/bionomia/dwc_agent](https://github.com/bionomia/dwc_agent)).
- `csv2tsv.py filename.csv` — will convert files having the format of comma separated values (CSV) to tabulator separated values (TSV) using [pandas.pydata.org (`dataframe.to_csv`)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_csv.html#pandas-dataframe-to-csv)

## Parsing of Name Lists

Often you have multiple names in a list and want to separate them. For this you can use the Ruby gem package <https://libraries.io/rubygems/dwc_agent>

`agent_parse4tsv.rb` parses names and skippes empty parsing results by default. For analysing name parsing you can use options `--logfile` or/and `--develop`, explained in the help text messages:

```bash
ruby agent_parse4tsv.rb --help # show help and usage
  # Usage: ruby agent_parse4tsv.rb [options]
  #   (version of dwc_agent: 3.4.2.0)
  # 
  #   We read tabulator separated input data and parse the names (from the 1st column)
  #   The text data must have a column header; if there are any other columns, they will be added to the parsed output.
  #   input (default) data/VHde_doi-10.15468-dl.tued2e/occurrence_recordedBy_occurrenceIDs_20230524.tsv
  #   output (default) data/VHde_doi-10.15468-dl.tued2e/occurrence_recordedBy_occurrenceIDs_20230524_parsed.tsv
  # 
  # Options: 
  #     -i, --input [input]              file and path of the input data (tsv)
  #     -o, --output [output]            file and path of the output (tsv)
  #     -d, --develop                    show parsed source strings anyway (extra column)
  #     -p, --parsing-level [level]      level of parsing: 0 = clean names (default); 1 = on empty cleaned this_name_reversed use the parsed this_name_reversed; 2 = only do parsing, no cleaning
  #     -l, --logfile                    write log file with skipped names (into the output directory)
```

The input file must be in format of tabulator separated values (TSV), and the names in the first column, with the column header in the frist row …

- we also use option `--develop` to get the parsed names, cleaned names in extra columns

… then try something like:

```bash
ruby agent_parse4tsv.rb --develop \
  --input  ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv

# or check also running time of the parsing script with `time command`
time ruby agent_parse4tsv.rb --develop \
  --input  ../data/plazi_GbifOccurrenceId_CitCollector_20230719.tsv \
  --output ../data/plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv
  # real    5m2,451s
  # user    2m38,644s
  # sys     2m4,709s
```

### Analyse and Look Into the Parsed Names

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
  #   ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv_dwcagent_3.0.12.0.log
  # Wrote data to
  #   ../data/Meise_doi-10.15468-dl.ax9zkh/occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv
  # -------------------------
  # real    1m17,880s
  # user    0m40,357s
  # sys     0m24,719s
```

Analyse the logged parsed names and write a markdown table output:

```bash
cd ../data/Meise_doi-10.15468-dl.ax9zkh/
file="occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv_dwcagent_3.0.12.0.log";
awk --field-separator=$'\t' '
  BEGIN { 
    print "| related_parsed_name | after cleaning empty | source string | comment |\n|  --- | --- | --- | --- |" 
  } 
  { 
    if ($2 && FNR > 1) { 
      print "| `" $2 "` | at " $5 " | `" $1 "` |   | " 
    } 
  }' "${file}" \
  | column --output-separator '|'  --table --separator '|' \
  > skipped_names.md

# format nicer looking markdown table in general
cat skipped_names.md | column --output-separator '|'  --table --separator '|'
# | related_parsed_name | after cleaning empty | source string         | comment |
# |  ---                | ---                  | ---                   | ---     |
# | `J. B.`             | at cleaned_0index:0  | `? J. B.`             |         | 
# | `F.M.C. V.`         | at cleaned_0index:0  | `?F.M.C. V.`          |         | 
# | `Jean Malvaux sc.`  | at cleaned_0index:0  | `?Jean Malvaux sc.`   |         | 
# | `B. K.`             | at cleaned_0index:1  | `?P.E.G. & B. K.`     |         | 
```

#### Get names with with square brackets `[]`

We use `--develop` to get the source input as well

```bash
cd /collector-matching/data/Meise_doi-10.15468-dl.ax9zkh/

time ruby ../../bin/agent_parse4tsv.rb --develop \
  --input  occurrence_recordedBy_eventDate_occurrenceIDs_20230830.tsv \
  --output occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv

# We have the given file structure 
#   family → given → suffix → particle → dropping_particle → nick → appellation → title → source_data → parsed_names → cleaned_names → …
#   $1     → $2    → $3     → $4       → $5                → $6   → $7          → $8    → $9          → $10          → $11           → …
file="occurrence_recordedBy_eventDate_occurrenceIDs_20230830_parsed.tsv";
awk --field-separator=$'\t' '
  BEGIN { 
    print "| family | given | … | source_data | parsed_names | cleaned_names |\n| --- | --- | --- | --- | --- | --- |" 
  } 
  { 
    # if ($9 ~ /(\[|\])/ && FNR > 1) { # all and any “[” or “]”
    if ($9 ~ /([^\b ]\[[^ .]+\][^\b ])/ && FNR > 1) { # brackets inbetween a this_name_reversed string, like `Buto[m]a`
      print "| " $1 " | " $2 " | … | `" $9 "` | `" $10 "` | `" $11 "` | " 
    } 
  }' "${file}" \
  | column --output-separator '|'  --table --separator '|' \
  > source_names_with_brackets_inbetween.md
```


## Convert CSV Data to TSV

Use `csv2tsv.py filename.csv` and it will convert it to `filename.csv.tsv` having tabbed separated columns.
