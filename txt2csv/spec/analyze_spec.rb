require 'spec_helper'
require 'analyze.rb'
require 'pry'

# First, define methods used to create the test files.
# We create the test files here
#   1) so that the test can be run on its own and
#   2) so the contents of the file are clear

def create_test_file (filename)
  File.open(filename, "w") do |f|
    5.times  {f.puts "Mr. Jones"}
    6.times  {f.puts "Miss Smith"}
    4.times  {f.puts "Mrs. Wesson"}
    10.times {f.puts "Dr. Roberts"}
    1.times  {f.puts "Jane Wintermute"}
    2.times  {f.puts "Frank Franklin"}
    3.times  {f.puts "Darleen Washington"}
 end
end

def create_prefix_expected_file (filename)
  # Note sort order - by count, not by word
  File.open(filename, "w") do |f|
    f.puts "Dr. 10"
    f.puts "Miss 6"
    f.puts "Mr. 5"
    f.puts "Mrs. 4"
    f.puts "Darleen 3"
    f.puts "Frank 2"
    f.puts "Jane 1"
  end
end

def create_suffix_expected_file (filename)
  File.open(filename, "w") do |f|
    f.puts "Roberts 10"
    f.puts "Smith 6"
    f.puts "Jones 5"
    f.puts "Wesson 4"
    f.puts "Washington 3"
    f.puts "Franklin 2"
    f.puts "Wintermute 1"
  end
end

describe "Analyze" do

  # Set up the files need for the specifications
  # put them down in the spec folder so they don't clutter the project root folder

  before(:all) do
    create_test_file 'spec/analyze_testfile.txt'
    create_prefix_expected_file 'spec/expected_prefixes.txt'
    create_suffix_expected_file 'spec/expected_suffixes.txt'
  end

  # clean up after ourselves

  after(:all) do
    File.delete 'spec/analyze_testfile.txt'
    File.delete 'spec/expected_prefixes.txt'
    File.delete 'spec/expected_suffixes.txt'
    File.delete 'spec/histogram.txt'
  end

  context "#initialization" do
    let(:analyze) { Analyze.new('spec/analyze_testfile.txt', 'spec/histogram.txt', '-p')}
    it "opens an input file for reading" do
      expect(analyze.instance_variable_get(:@input_file)).to be_a(File)
    end

    it "opens an output file for writing" do
      expect(analyze.instance_variable_get(:@output_file)).to be_a(File)
    end

    it "assigns fix to a variable" do
      expect(analyze.instance_variable_get(:@fix)).to eq('-p')
    end
  end

  context "#analyze" do
    it "reads a file and prints a hash of prefixes when given the -p option" do
      `bin/txt2csv analyze -p -i spec/analyze_testfile.txt -o spec/histogram.txt`
      IO.read('spec/histogram.txt').should == IO.read('spec/expected_prefixes.txt')
    end

    it "reads a file and prints a hash of suffixes when given the -s option" do
      `bin/txt2csv analyze -s -i spec/analyze_testfile.txt -o spec/histogram.txt`
      IO.read('spec/histogram.txt').should == IO.read('spec/expected_suffixes.txt')
    end
  end

  context "#pick_pattern prefixes" do
    let(:analyze) { Analyze.new('spec/analyze_testfile.txt', 'spec/histogram.txt', '-p')}
    it "selects the appropriate pattern for prefixes" do
      expect(analyze.pick_pattern).to eq(/^[\w\.]+/)
    end
  end

  context "#pick_pattern suffixes" do
    let(:analyze) { Analyze.new('spec/analyze_testfile.txt', 'spec/histogram.txt', '-s')}
    it "selects the appropriate pattern for suffixes" do
      expect(analyze.pick_pattern).to  eq(/[\w]+$/)
    end

  end
end
