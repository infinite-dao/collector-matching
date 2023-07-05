# Usage parse a tab seperated file (with column header) and parse the name list
#   contained in column one. Input data can have additional columns that should
#   be appended to the parsed columns

# test the time usage in BASH/Unix by: `time ruby agent_parse.rb `
require 'dwc_agent' # installation see https://libraries.io/rubygems/dwc_agent

# TODO missing values with `dwcagent "ABR"` returns [] — now resulting in empty lines
# TODO some names become divided into 2 entries or data get deleted partially
#  dwcagent "A. Cano,E."
# [{"family":"Cano","given":"A.","suffix":null,"particle":null,"dropping_particle":null,"nick":null,"appellation":null,"title":null}]

input_file_path = 'data/VHde_0195853-230224095556074_BGBM/occurrence_recordedBy_occurrenceIDs_20230524.tsv'
output_file_path = 'data/VHde_0195853-230224095556074_BGBM/occurrence_recordedBy_occurrenceIDs_20230524_parsed.tsv'

require 'optparse'

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: ruby agent_parse4tsv.rb [options]\n" \
      + "\n" \
      + "  We read tabulator seperated input data and parse the names (from the 1st column)\n" \
      + "  The text data must have a column header; if there are any other columns, they will be added to the parsed output.\n" \
      + "  input (default) \033[0;34m" + input_file_path + "\033[0m\n" \
      + "  output (default) \033[0;34m" + output_file_path + "\033[0m\n" \
      + "\nOptions: \n"
  opt.on('-i [input]', '--input', 'file and path of the input data (tsv)') { |o| options[:input] = o }
  opt.on('-o [output]', '--output', 'file and path of the output (tsv)') { |o| options[:output] = o }
  options = { input: input_file_path, output: output_file_path }
  opt.parse!(into: options)
end.parse!

# puts options # debug

# do_something unless some_condition
abort("\033[0;33mInput data not found\033[0m (STOP. Change the input file path in this script)") unless File.exist?(options[:input])

# # # # # # main code # # # # # #
input_file_path = options[:input]
output_file_path = options[:output]

printf "We read tabulator seperated input data and parse the names (from the 1st column)\n"
printf "The text data must have a column header; if there are any other columns, they will be added to the parsed output.\n"
printf "- read data from \033[0;34m" + input_file_path + "\033[0m\n"
printf "- rite data to \033[0;34m" + output_file_path + "\033[0m\n"
printf "\033[0;33mContinue?\033[0m (type “y” or press any key to continue): "

prompt = STDIN.gets.chomp
exit unless prompt.downcase == 'y' || prompt.downcase == ''

# Parse tab seperated file that contains a header this_row
class StrictTsv
  attr_reader :filepath
  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    open(filepath) do |f|
      headers = f.gets.strip.split("\t")
      f.each do |line|
        fields = Hash[headers.zip(line.split("\t"))]
        yield fields
      end
    end
  end
end



i_input_line = 0
  # i_input_line is without the header line, it is the first row of data

dwc_agent_column_names = ["family", "given", "suffix", "particle", "dropping_particle", "nick", "appellation", "title"]
this_tsv = StrictTsv.new(input_file_path)
  # Opens the input file
  # expect header this_row + first column contains the name list

this_tsv.parse do |this_row|
  # Iterate over each this_row/line in the input file
  # puts this_row['named field']
  i_input_line+=1; current_output_line=""; column_names = this_row.keys

  # add header output
  if i_input_line == 1
    current_output_line += dwc_agent_column_names.join("\t")
    if column_names.length > 1
      current_output_line += "\t" + column_names[1..].join("\t")
    end
    current_output_line +="\n"
  end

  other_column_data="" # check for other columns
  if column_names.length > 1
    column_names[1..].each do |field|
      other_column_data+= "\t" + this_row[field].chomp
    end
  end

  parsed_names = DwcAgent.parse(this_row[column_names[0]].chomp) # chomp ~ mampfen
  cleaned_names = parsed_names.map { |field| DwcAgent.clean(field) }

  # cleaned_names.each_with_index { |item, i_name| puts "item #{item} with index #{i_name}" }
  cleaned_names.each_with_index {
    |this_cleaned_name, i_name| current_output_line+= "#{
      this_cleaned_name.values_at(:family, :given, :suffix, :particle, :dropping_particle, :nick, :appellation, :title)
          .join("\t") + other_column_data + "\n"
    }"
  }
  # print current_output_line, "\n"
  File.open(
    output_file_path,
    i_input_line == 1 ? "w" : "a"
  ) do |output_file|
    output_file.puts current_output_line.chomp
  end
  # break  if i_input_line > 20
end

printf "Wrote data to \033[0;34m" + output_file_path + "\033[0m\n"
printf "\033[0;32mDone.\033[0m\n"
