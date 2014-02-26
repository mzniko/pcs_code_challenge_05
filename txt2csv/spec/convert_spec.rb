require 'spec_helper'
require 'convert.rb'
require 'pry'

def create_expected_clean_csv_file(filename)
  File.open(filename, "w") do |f|
    f.puts "Prefix,First,Middle,Last,Suffix,Country,Area,Phone-Prefix,Line,Extension,Handle,Address\n\nMr.,Marko,\"\",Nikolovski,I,\"\",555,123,1234,\"\",mzniko,\"mz.nikolovski@gmail.com\n\"\nDr.,Jeff,\"\",Stringer,III,\"\",555,833,5486,\"\",jeffstringer,\"jeff.j.stringer@gmail.com\n\"\n"
  end
end

def create_testfile(filename)
  File.open(filename, "w") do |f|
    f.puts "Mr. Marko Nikolovski I\t555-123-1234\t@mzniko\tmz.nikolovski@gmail.com"
    f.puts "Dr. Jeff Stringer III\t555-833-5486\tjeffstringer\tjeff.j.stringer@gmail.com"
  end
end


def create_prefix_file (filename)
  # Note sort order - by count, not by word
  File.open(filename, "w") do |f|
    f.puts "Dr. 10"
    f.puts "Miss 6"
    f.puts "Mr. 5"
    f.puts "Mrs. 4"
  end
end

def create_suffix_file (filename)
  File.open(filename, "w") do |f|
    f.puts "Sr. 10"
    f.puts "Jr. 6"
    f.puts "I 5"
    f.puts "II 4"
    f.puts "III 3"
  end
end

describe "Convert" do
  let(:convert) { Convert.new('spec/prefixes.txt', 'spec/suffixes.txt',
                              'spec/convert_testfile.txt', 'spec/clean_csv.txt')}

  before(:all) do
    create_expected_clean_csv_file 'spec/expected_clean_csv.txt'
    create_testfile 'spec/convert_testfile.txt'
    create_prefix_file 'spec/prefixes.txt'
    create_suffix_file 'spec/suffixes.txt'
  end

  # after(:all) do
  #   File.delete 'spec/prefixes.txt'
  #   File.delete 'spec/suffixes.txt'
  #   File.delete 'spec/clean_csv.txt'
  #   File.delete 'spec/expected_clean_csv.txt'
  #   File.delete 'spec/convert_testfile.txt'
  # end

  context "#initialization" do

    it "opens an input file for reading" do
      expect(convert.instance_variable_get(:@input_file)).to be_a(File)
    end

    it "opens a prefix file for reading" do
      expect(convert.instance_variable_get(:@suffix_file)).to be_a(File)
    end

    it "opens a suffix file for reading" do
      expect(convert.instance_variable_get(:@prefix_file)).to be_a(File)
    end

  end

  context "#create_fix_arrays" do

    it "should create an array from the prefix file" do
      expect(convert.instance_variable_get(:@prefix)).to eq(["Dr.", "Miss", "Mr.", "Mrs."])
    end
    it "should create an array from the prefix file" do
      expect(convert.instance_variable_get(:@suffix)).to eq(["Sr.", "Jr.", "I", "II", "III"])
    end
  end

  context "#send_to_parser" do
    it "should create a correct clean csv file from a tab-delimited file" do
      `bin/txt2csv convert -p spec/prefixes.txt -s spec/suffixes.txt -i spec/convert_testfile.txt -o spec/clean_csv.txt`
      expect(IO.read('spec/clean_csv.txt')).to eq(IO.read('spec/expected_clean_csv.txt'))
    end
  end

end

