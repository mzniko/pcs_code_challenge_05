require 'spec_helper'
require 'analyze.rb'
require 'pry'

# First, define methods used to create the test files.
# We create the test files here
#   1) so that the test can be run on its own and
#   2) so the contents of the file are clear

def create_test_file (filename)
  File.open(filename, "w") do |f|
    5.times  {f.puts "Mrs. Theresa E. Stamm\t1-678-523-6736\tReinger\tkieran@runte.biz"}
    6.times  {f.puts "Keara Maggio\t1-399-471-4388 x9581\t@Weber\tcayla@lubowitz.com"}
    4.times  {f.puts "Daren S. Padberg DVM\t240-399-5583\tx73790 Hessel\taugusta@stoltenberg.com"}
    10.times {f.puts "Mr. Claud Auer\t(561)024-9548 x165\t@Mraz\tjettie_friesen@weber.com"}
    1.times  {f.puts "Miss Sam Parisian\t818-657-9309 x5633\t@Quigley\tlavon.quitzon@schinnercain.biz"}
    2.times  {f.puts "Ciara X. Windler II\t575-225-1469 x240\tLabadie\tryan_moore@hagenesmiller.com"}
    3.times  {f.puts "Davion G. Streich\t333-783-4674 x18711\tSchneider\tole.bashirian@murazikmonahan.org"}
 end
end

def create_prefix_expected_file(filename)
  # Note sort order - by count, not by word
  File.open(filename, "w") do |f|
    f.puts "Mr. 10"
    f.puts "Keara 6"
    f.puts "Mrs. 5"
    f.puts "Daren 4"
    f.puts "Davion 3"
    f.puts "Ciara 2"
    f.puts "Miss 1"
  end
end

def create_suffix_expected_file(filename)
  File.open(filename, "w") do |f|
    f.puts "Auer 10"
    f.puts "Maggio 6"
    f.puts "Stamm 5"
    f.puts "DVM 4"
    f.puts "Streich 3"
    f.puts "II 2"
    f.puts "Parisian 1"
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
    let(:analyze) { Analyze.new('-p', 'spec/analyze_testfile.txt', 'spec/histogram.txt')}
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
    let(:analyze) { Analyze.new('-p', 'spec/analyze_testfile.txt', 'spec/histogram.txt')}
    it "selects the appropriate pattern for prefixes" do
      expect(analyze.pick_pattern).to eq(/^[\w\.]+/)
    end
  end

  context "#pick_pattern suffixes" do
    let(:analyze) { Analyze.new('-s', 'spec/analyze_testfile.txt', 'spec/histogram.txt')}
    it "selects the appropriate pattern for suffixes" do
      expect(analyze.pick_pattern).to  eq(/[\w]+[\.]?$/)
    end

  end
end
