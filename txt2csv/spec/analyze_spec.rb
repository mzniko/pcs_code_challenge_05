require 'spec_helper'

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

describe TXT2CSV::Txt2csv do

  # Set up the files need for the specifications
  # put them down in the spec folder so they don't clutter the project root folder

  before(:all) do
    create_test_file 'spec/testfile.txt'
    create_prefix_expected_file 'spec/expected_prefixes.txt'
    create_suffix_expected_file 'spec/expected_suffixes.txt'
  end

  # clean up after ourselves

  after(:all) do
    File.delete 'spec/testfile.txt'
    File.delete 'spec/expected_prefixes.txt'
    File.delete 'spec/expected_suffixes.txt'
    File.delete 'bin/histogram.txt'
  end

  describe "#analyze" do
    context "when analyze is run from the CLI"
      let(:analyze) { Txt2csv.start(['-p', '-i', '../spec/testfile.txt', '-i', 'histogram.txt']) }

      it "reads a file and prints a hash of prefixes when given the -p option" do
        IO.read('bin/histogram.txt').should == IO.read('spec/expected_prefixes.txt') { analyze }
      end

      let(:analyze) { Txt2csv.start(['-p', '-i', '../spec/testfile.txt', '-i', 'histogram.txt']) }

      it "reads a file and prints a hash of suffixes when given the -s option" do
        IO.read('bin/histogram.txt').should == IO.read('spec/expected_suffixes.txt') { analyze }
      end
    end
  end

end
