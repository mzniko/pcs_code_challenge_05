#!/usr/bin/env ruby
require 'csv'

class Convert
  def initialize(input_file_name, prefix_file_name, suffix_file_name, output_file_name)
    @input_file = File.new(input_file_name, 'r')
    #@prefix_file_name = create array
    #@suffix_file_name = create array
    #@output_file = CSV.new(output_file_name, 'w')   
  end

  def convert


   @input_file.each_line do |line| 
      #line_array = CSV.parse_line(line, :col_sep => '\t' )
      
   end    

  end 






end  