#!/usr/bin/env ruby
require 'csv'
require_relative 'parse.rb'

class Convert
  def initialize(prefix_file_name, suffix_file_name, input_file_name, output_file_name)
    @input_file = File.new(input_file_name, 'r')
    @prefix_file = File.new(prefix_file_name, 'r')
    @suffix_file = File.new(suffix_file_name, 'r')
    @output_file_name = output_file_name
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
    CSV.open(@output_file_name, 'w', :write_headers => true, :headers => ["Prefix", "First", "Middle", "Last", "Suffix", "Country", "Area", "Phone-Prefix", "Line", "Extension","Handle","Address"]) do |csv|
      csv << [nil]
    end
    @input_file.each_line do |line|
      unparsed_strings_array = line.split("\t")
      to_csv = []
      to_csv << Parse.parse_names(@prefix, @suffix, unparsed_strings_array[0])
      to_csv << Parse.parse_phone(unparsed_strings_array[1])
      to_csv << Parse.parse_twitter(unparsed_strings_array[2])
      to_csv << Parse.parse_email(unparsed_strings_array[3])
      CSV.open(@output_file_name, 'ab') do |csv|
        csv << to_csv.flatten
      end
    end
  end
  # def clean_array(dirty_array)
  #   dirty_array.reject { |member| member.empty? }
  # end
end
