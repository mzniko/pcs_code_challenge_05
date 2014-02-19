require 'spec_helper'

require 'parse.rb'

describe Parse do

  it 'should parse area code, prefixes and lines' do
    return_array = Parse.parse_phone('222.333.4444')
    expect(return_array).to eq(['', '222', '333', '4444', ''])
  end

  it 'should parse country code, area code, prefixes, lines and extensions' do
    return_array = Parse.parse_phone('1-222-333-4444 x1234')
    expect(return_array).to eq(['1', '222', '333', '4444', '1234'])
  end

  it 'should parse area code, prefixes, lines and extensions' do
    return_array = Parse.parse_phone('(222)333-4444 x123')
    expect(return_array).to eq(['', '222', '333', '4444', '123'])
  end

  it 'should parse county code, area code, prefixes and lines' do
    return_array = Parse.parse_phone('1.222-333-4444')
    expect(return_array).to eq(['1', '222', '333', '4444', ''])
  end

  it 'should parse the whole enchilada' do
    return_array = Parse.parse_phone('1.222.333.4444 x12345')
    expect(return_array).to eq(['1', '222', '333', '4444', '12345'])
  end

end
