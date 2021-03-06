#!/usr/bin/env ruby
require 'csv'
require 'pry'

# This analyzes names to create a histogram of prefixes or suffixes
class Analyze
  def initialize(fix, input_file_name, output_file_name)
    @input_file = File.new(input_file_name, 'r')
    @output_file = File.new(output_file_name, 'w')
    @fix = fix
    analyze
  end

  def analyze
    histogram = Hash.new(0)
    pattern = pick_pattern

    @input_file.each_line do |line|
      line_array = line.split("\t")
      hash_data = regex(pattern, line_array[0])
      histogram[hash_data.to_sym] += 1
    end

    histogram = Hash[ histogram.sort_by { |word, count| count }.reverse]
    histogram.each { |word, count| @output_file.puts("#{word} #{count}") }
  end

  def pick_pattern
    case @fix
    when '-p'
      pattern = /^[\w\.]+/
    when '-s'
      pattern = /[\w]+[\.]?$/
    end
    pattern
  end

  def regex(pattern, line)
    pattern.match(line).to_s
  end
end
