### Helpful commands for viewing TSV files

Display the first 6 lines of a tabular (separated by `\t`) sample data table:

```bash
head -n 6 "plazi_GbifOccurrenceId_CitCollector_20230719.tsv" | column -t -s $'\t'

tsvfile="plazi_GbifOccurrenceId_CitCollector_20230719.tsv"
head -n 6 "${tsvfile}" | column -t -s $'\t'
# just columns 1 to 5
head -n 6 "${tsvfile}" | cut -f1-5 | column -t -s $'\t'
```

```plain
MatCitCollector                             DocCount  MatCitId                          MatCitGbifOccurrenceId  MatCitDate  MatCitDecade  MatCitYear  MatCitMonth
1888 - 1890 & Morong, T.                    1         78F03CF8FFE2FFE5C0C4F883FE73F8B4  3419301320                          0             0           0
1914 & Chodat, R.                           1         78F03CF8FFE5FFE2C187FB83FD0AFB94  3419301397                          0             0           0
1980 - Sino- American Botanical Expedition  1         1FFD3CFF806D3D11C410027311B3FEAC  4012799597              1980-09-19  1980          1980        9
20. 8.201 3 & Delage, A.                    1         AFA17A73FFA8F2414DA6F9AB94DCF942  3466701331                          0             0           0
20. IX. 1957 & fr., Service Forestier       1         87ADD56BFF8DFF9BFBA0164C25E5FA86  3467693310                          0             0           0
```

Sort the data, and display the first 6 lines of a tabular (separated by `\t`) sample data table that was parsed with `dwcagent`:

```bash
# tsvfile="plazi_GbifOccurrenceId_CitCollector_20230719.tsv"

### 2nd column sorted in reverse order (here the “given“ name column)
tsvfile="plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv"
head -n 1 "${tsvfile}" \
    && tail -n +2 "${tsvfile}" | sort -t$'\t' -k2,2r | head -n 5
    # save it to a temporary test file
    # (head -n 1 "${tsvfile}" && tail -n +2 "${tsvfile}" | sort -t$'\t' -k2,2r | head -n 5) > test_sorted.tsv
    # pandoc "test_sorted.tsv" -f tsv -t gfm # TSV into markdown table

### 1st column is sorted in reverse order (here the “family” name column)
tsvfile="plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv"
head -n 1 "${tsvfile}" \
    && tail -n +2 "${tsvfile}" | sort -t$'\t' -k1,1r | head -n 5
    # save it to a temporary test file
    # (head -n 1 "${tsvfile}" && tail -n +2 "${tsvfile}" | sort -t$'\t' -k1,1r | head -n 5) > test_sorted.tsv
    # pandoc "test_sorted.tsv" -f tsv -t gfm # TSV into markdown table
```

```plain
family	given	suffix	particle	dropping_particle	nick	appellation	title	source_data	parsed_names	cleaned_names	DocCount	MatCitId	MatCitGbifOccurrenceId	MatCitDate	MatCitDecade	MatCitYear	MatCitMonth
Fisher	в L.							Fisher, В. L.; et al.	parsed:в L. Fisher	cleaned:в L. Fisher	1	4CFA1DA7990F02B7BB4E89A6F08DA2D9	923898907		0	0	0
Schnitnikov	А.							А. Schnitnikov	parsed:А. Schnitnikov	cleaned:А. Schnitnikov	1	3B7C3CAD6B18FFBCADDEFA01FE543FE5	3034555558	1956-06-20	1950	1956	6
Calame	Τhomas							Vinh Quang Luu, Τhomas Calame & Kieusomphone Thanabuaosy	parsed:Vinh Quang Luu<SEP>Τhomas Calame<SEP>Kieusomphone Thanabuaosy	cleaned:Vinh Quang Luu<SEP>Τhomas Calame<SEP>Kieusomphone Thanabuaosy	1	8A9262763028FFBEFBFAF88D0175F875	2466103895	2015-03-29	2010	2015	3
Gao	Z.Z.							L. Y. Wang & G. Q. Huang & Z. Z. Gao	parsed:L.Y. Wang<SEP>G.Q. Huang<SEP>Z.Z. Gao	cleaned:L.Y. Wang<SEP>G.Q. Huang<SEP>Z.Z. Gao	1	3B6FC359FFC8A1570B8BF9708B6A9383	2609011227	2015-10-16	2010	2015	10
Gao	Z.Z.							L. Y. Wang & G. Q. Huang & Z. Z. Gao	parsed:L.Y. Wang<SEP>G.Q. Huang<SEP>Z.Z. Gao	cleaned:L.Y. Wang<SEP>G.Q. Huang<SEP>Z.Z. Gao	1	3B6FC359FFC8A1570F12F9548D69925F	2609011229	2015-10-16	2010	2015	10
```

Only evaluate and arrange specific columns, e.g., columns 1 to 11:

```bash
### 1st column is sorted in reverse order (here the “family” name column but only columns 1 to 11)
tsvfile="plazi_GbifOccurrenceId_CitCollector_20230719_parsed.tsv"
head -n 1 "${tsvfile}" | cut -f1-11 \
    && tail -n +2 "${tsvfile}" | sort -t$'\t' -k1,1r | head -n 5 | cut -f1-11

```
