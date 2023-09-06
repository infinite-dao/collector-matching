# Usage parse a tab seperated file (with column header) and parse the name list
#   contained in column one. Input data can have additional columns that should
#   be appended to the parsed columns

# test the time usage in BASH/Unix by: `time ruby agent_parse.rb `
require 'dwc_agent' # installation see https://libraries.io/rubygems/dwc_agent

# TODO missing values with `dwcagent "ABR"` returns [] — now resulting in empty lines
# TODO some names become divided into 2 entries or data get deleted partially
#  dwcagent "A. Cano,E."
# [{"family":"Cano","given":"A.","suffix":null,"particle":null,"dropping_particle":null,"nick":null,"appellation":null,"title":null}]

# some default variables
input_file_path = 'data/VHde_doi-10.15468-dl.tued2e/occurrence_recordedBy_occurrenceIDs_20230524.tsv'
output_file_path = 'data/VHde_doi-10.15468-dl.tued2e/occurrence_recordedBy_occurrenceIDs_20230524_parsed.tsv'

dwc_agent_column_names = ["family", "given", "suffix", "particle", "dropping_particle", "nick", "appellation", "title"]

develop_flag_show_parsed_source = false
column_name_source_data = "source_data"
supplementary_developer_info_column_names = ["parsed_names", "cleaned_names"]

develop_flag_write_logfile = false
log_file_name = File.basename(output_file_path + ".log")
log_file_path = output_file_path + ".log"
log_file_column_names = ["source_data", "parsed_names", "cleaned_names", "name_index_of_empty_result"]

require 'optparse'

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: ruby agent_parse4tsv.rb [options]\n" \
      + "\n" \
      + "  We read tabulator separated input data and parse the names (from the 1st column)\n" \
      + "  The text data must have a column header; if there are any other columns, they will be added to the parsed output.\n" \
      + "  input (default) \033[0;34m" + input_file_path + "\033[0m\n" \
      + "  output (default) \033[0;34m" + output_file_path + "\033[0m\n" \
      + "\nOptions: \n"
  opt.on('-i [input]', '--input', 'file and path of the input data (tsv)') { |o| options[:input] = o }
  opt.on('-o [output]', '--output', 'file and path of the output (tsv)') { |o| options[:output] = o }
  opt.on('-d', '--develop', 'show parsed source strings anyway (extra column)') { |o| options[:developer_report] = o }
  opt.on('-l', '--logfile', 'write log file with skipped names (into the output directory)') { |o| options[:do_log_report] = o }
  options = { 
    input: input_file_path, 
    output: output_file_path, 
    developer_report: develop_flag_show_parsed_source, 
    do_log_report: develop_flag_write_logfile
  }
  opt.parse!(into: options)
end.parse!

# puts options # debug

# do_something unless some_condition
abort("\033[0;33mInput data not found\033[0m (STOP. Change the input file path in this script)") unless File.exist?(options[:input])

# # # # # # main code # # # # # #
input_file_path = options[:input]
output_file_path = options[:output]
develop_flag_show_parsed_source = options[:developer_report]
develop_flag_write_logfile = options[:do_log_report]

log_file_name = File.basename(output_file_path + ".log")
log_file_path = output_file_path + ".log"

printf "We read tabulator separated input data and parse the names (from the 1st column)\n"
printf "The text data must have a column header; if there are any other columns,\nthey will be added to the parsed output.\n"
printf "\nUse --logfile or --develop to log empty names or check full parsing results.\nBy default empty parsing results will completely be removed from the output.\n"
printf "\nNow:\n"
printf "- read data from \033[0;34m" + input_file_path + "\033[0m\n"
printf "- write data to  \033[0;34m" + output_file_path + "\033[0m\n"
if develop_flag_show_parsed_source
printf "- add columns \033[0;34m" + sprintf("%s, %s", column_name_source_data, supplementary_developer_info_column_names.join(", ")) + "\033[0m e.g. for a \033[0;33mdeveloper report\033[0m\n"
end
if develop_flag_write_logfile
printf "- write log (with tabbed columns) of skipped names into output directory as well: \033[0;34m" + log_file_name + "\033[0m\n"
end


printf "\n\033[0;33mContinue?\033[0m (type “y” or press any key to continue): "

prompt = STDIN.gets.chomp
exit unless prompt.downcase == 'y' || prompt.downcase == ''

printf "\033[0;32mRun parsing data…\033[0m\n"

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


n_empty_parsing_results_detected = 0
i_input_line = 0
  # i_input_line is without the header line, it is the first row of data

this_tsv = StrictTsv.new(input_file_path)
  # Opens the input file
  # expect header this_row + first column contains the name list

this_tsv.parse do |this_row|
  # Iterate over each this_row/line in the input file
  # puts this_row['named field']
  i_input_line+=1; 
  current_output_line=""; 
  current_logfile_line="";
  source_names_tabbed_output = ""
  supplementary_developer_info_tabbed_output = ""
  column_names = this_row.keys;

  has_additional_data_columns=0
  if column_names.length > 1
    has_additional_data_columns=1
  end
  other_column_data_tabbed_output="" # check for other columns
  
  # var=sprintf("i_input_line: %d\n", i_input_line)
  if i_input_line == 1
    # add header output
    current_output_line += dwc_agent_column_names.join("\t")
    if develop_flag_show_parsed_source
      # TODO add supplementary_developer_info_column_names adjacent to source_data
      current_output_line += "\t" + column_name_source_data + "\t" + supplementary_developer_info_column_names.join("\t")
    end
    if has_additional_data_columns
      current_output_line += "\t" + column_names[1..].join("\t")
    end
    current_output_line +="\n"
    
  else # other (real) data lines
    # prepare data row
    if has_additional_data_columns
      column_names[1..].each do |field|
        other_column_data_tabbed_output+= "\t" + this_row[field].chomp
      end
    end
    source_names = this_row[column_names[0]]
    
    parsed_names = DwcAgent.parse(source_names.chomp) # chomp ~ mampfen
    cleaned_names = parsed_names.map { |field| DwcAgent.clean(field) }
    # cleaned_names array length is always 1
    # length_current_output_line = current_output_line.length
    
    if develop_flag_show_parsed_source
      source_names_tabbed_output = "\t" + source_names # it gets inserted, hence the \t prefix
    end
    supplementary_developer_info_tabbed_output = "\tparsed:" + parsed_names.join("<SEP>") + "\tcleaned:" + cleaned_names.join("<SEP>")
    
    # TODO Gabrielian,E.Tz., Hein,P. & Raab-Straube,E. von VHde Data fälschlich als empty ausgegeben!! Prüfen
    # puts sprintf("debug: row: %d parsed %s", i_input_line, parsed_names.join("<SEP>"))
    
    # check and loop through the parsed results
    
    # if cleaned_names.join("").length > 0 # one or more names in this_row
    if parsed_names.join("").length > 0
      cleaned_names.each_with_index do |this_cleaned_name, i_name|
        # this_cleaned_name here, is some kind of Namae object, try to check for empty parsing results
        if this_cleaned_name.values_at(:family, :given, :suffix, :particle, :dropping_particle, :nick, :appellation, :title).join("").length > 0
          current_output_line+= "#{
            this_cleaned_name.values_at(:family, :given, :suffix, :particle, :dropping_particle, :nick, :appellation, :title)
                .join("\t") + source_names_tabbed_output + supplementary_developer_info_tabbed_output + other_column_data_tabbed_output + "\n"
          }"
        else # somehow empty parsed name
          n_empty_parsing_results_detected += 1
          if develop_flag_show_parsed_source 
            # force output anyway if source_names is requested
            cleaned_names_supplement_for_empty_parse_data = Array.new(dwc_agent_column_names.length, "\t").join("")
            current_output_line+= cleaned_names_supplement_for_empty_parse_data + source_names_tabbed_output + supplementary_developer_info_tabbed_output + other_column_data_tabbed_output + "\n"
          end
          if develop_flag_write_logfile
            current_logfile_line+= sprintf("%s%s\tcleaned_index0:%d\n", source_names, supplementary_developer_info_tabbed_output, i_name)
          end
        end
      end
    else # no parsed names at all in this_row for some reason
      n_empty_parsing_results_detected += 1
      if develop_flag_show_parsed_source 
        # force output anyway if source_names is requested
        cleaned_names_supplement_for_empty_parse_data = Array.new(dwc_agent_column_names.length, "\t").join("")
        current_output_line+= cleaned_names_supplement_for_empty_parse_data + source_names_tabbed_output + supplementary_developer_info_tabbed_output + other_column_data_tabbed_output + "\n"
      else
        current_output_line= "" # force line to be empty
      end
      if develop_flag_write_logfile
        current_logfile_line+= sprintf("%s%s\tcleaned_index0:%d\n", source_names, supplementary_developer_info_tabbed_output, 0)
      end      
    end

  # debug
    
  end # if else i_input_line == 1

  if i_input_line == 1 # always write the file
    File.open( output_file_path, "w" ) do |output_file|
        output_file.puts current_output_line.chomp
    end
  else 
    if current_output_line.length > 0
      # append text
      File.open( output_file_path, "a" ) do |output_file|
          output_file.puts current_output_line.chomp
      end
    end
  end 
  
  if develop_flag_write_logfile
    if i_input_line == 1 # always write the file
      current_logfile_line+= log_file_column_names.join("\t") # + "\n"
      File.open( log_file_path, "w" ) do |this_log_file|
        this_log_file.puts current_logfile_line.chomp
      end
    else
      if current_logfile_line.length > 0
        # append text
        File.open( log_file_path, "a" ) do |this_log_file|
          this_log_file.puts current_logfile_line.chomp
        end
      end
    end
  end
  # break  if i_input_line > 20
end

# Final output
printf "-------------------------\n"
printf "\033[0;32mDone.\033[0m\n"
if n_empty_parsing_results_detected > 0
printf("We have \033[0;34m%d\033[0m empty parsing results detected.\n", n_empty_parsing_results_detected)
  if develop_flag_write_logfile && develop_flag_show_parsed_source
    printf "  Wrote logfile and full data results (including empty parsing)\n"
  elsif develop_flag_write_logfile
    printf "  You can also use --develop to get a full result table including the used source data of each parsed line\n"
  elsif develop_flag_show_parsed_source
    printf "  You can also use --logfile to just get a list of skipped names\n"
  else
    printf "  Use --logfile to get a list of skipped names or\n"
    printf "  Use --develop to get a full result table including source data, to investigate the names in more detail\n"
  end
end
if develop_flag_write_logfile
printf "Wrote log file of skipped names to\n  \033[0;34m" + log_file_path + "\033[0m\n"
end
printf "Wrote data to\n  \033[0;34m" + output_file_path + "\033[0m\n"

printf "-------------------------\n"
