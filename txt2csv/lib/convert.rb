#!/usr/bin/env ruby
require 'csv'
require '../lib/parse.rb'

class Convert
  def initialize(input_file_name, prefix_file_name, suffix_file_name, output_file_name)
    @input_file = File.new(input_file_name, 'r')
    @prefix_file = File.new(prefix_file_name, 'r')
    @suffix_file = File.new(suffix_file_name, 'r')
    @output_file = File.new(output_file_name, 'w')
    @prefix = Array.new
    @suffix = Array.new
    create_fix_arrays
    send_to_parser
  end

  def create_fix_arrays
    @prefix_file.each_line { |line| @prefix << line.split[0] }
    @suffix_file.each_line { |line| @suffix << line.split[0] }
  end

  def send_to_parser
    @input_file.each_line do |line|
      parsed_strings = []
      unparsed_strings_array = CSV.parse_line(line, :col_sep => '\t')
      parsed_strings << Parse.parse_names(@prefix, @suffix, unparsed_strings_array[0])
      parsed_strings << Parse.parse_phone(unparsed_strings_array[1])
      parsed_strings << Parse.parse_twitter(unparsed_strings_array[2])
      parsed_strings << Parse.parse_email(unparsed_strings_array[3])
      @output_file.puts(parsed_strings.join(" "))
    end
  end

end
