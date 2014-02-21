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
  end

  def convert

    @prefix_file.each_line do |line| 
      @prefix << line.split[0]

    @suffix_file.each_line do |line|
      @suffix = line.split[0]
    



   end    



  end 






end  