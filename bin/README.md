A collection of tools.

`agent_parse4tsv.rb` — parses tabulator separated files and needs <https://libraries.io/rubygems/dwc_agent> to be installed.

```bash
# change the code inside for file input and output before running it normally like:
ruby agent_parse4tsv.rb

# or if you want to measure how fast it parses names, use `time …`
time ruby agent_parse4tsv.rb
# real    0m41,923s
# user    0m23,390s
# sys     0m16,252s
```
