require 'spec_helper'

require 'parse.rb'

prefixes = ['M.', 'Mrs.', 'Mr.', 'Dr.', 'Ms.', 'Sister', "Lady"]
suffixes = %w(Jr. Sr. II III IV PhD.)

describe Parse do

  it 'should parse last names' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Madona')
    expect(return_array).to eq(['', '', '', 'Madona', ''])
  end

  it 'should parse suffixes' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Madona Jr.')
    expect(return_array).to eq(['', '', '', 'Madona', 'Jr.'])
  end

  it 'should parse first names' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Mary Madona')
    expect(return_array).to eq(['', 'Mary', '', 'Madona', ''])
  end

  it 'should parse first names with suffixes' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Mary Madona Jr.')
    expect(return_array).to eq(['', 'Mary', '', 'Madona', 'Jr.'])
  end

  it 'should parse middle names' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Mary Samuel Madona')
    expect(return_array).to eq(['', 'Mary', 'Samuel', 'Madona', ''])
  end

  it 'should parse middle initials' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Mary S. Madona')
    expect(return_array).to eq(['', 'Mary', 'S.', 'Madona', ''])
  end

  it 'should parse middle names & suffixes' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Mary Samuel Madona III')
    expect(return_array).to eq(['', 'Mary', 'Samuel', 'Madona', 'III'])
  end

  it 'should parse prefixes and last names' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Lady Madona')
    expect(return_array).to eq(['Lady', '', '', 'Madona', ''])
  end

  it "should parse prefixes and last names and suffixes" do
    return_array = Parse.parse_names(prefixes, suffixes, 'Lady Madona III')
    expect(return_array).to eq(['Lady', '', '', 'Madona', 'III'])
  end

  it 'should parse the whole banana' do
    return_array = Parse.parse_names(prefixes, suffixes, 'Lady Mary Samuel Madona-Richey III')
    expect(return_array).to eq(['Lady', 'Mary', 'Samuel', 'Madona-Richey',  'III'])
  end

end
