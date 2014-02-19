require 'spec_helper'

require 'parse.rb'

describe Parse do

  it 'should parse for handles containing @, less than 15 characters' do
    return_array = Parse.parse_twitter('@string')
    expect(return_array).to eq(['string'])
  end

  it 'should parse for handles without an @, less than 15 characters' do
    return_array = Parse.parse_twitter('string')
    expect(return_array).to eq(['string'])
  end

  it 'should exclude handles with an @ and are too long' do
    return_array = Parse.parse_twitter('@fifteenistoomany')
    expect(return_array).to eq(['Not Valid'])
  end

  it 'should exclude handles without an @ and are too long' do
    return_array = Parse.parse_twitter('fifteenistoomany')
    expect(return_array).to eq(['Not Valid'])
  end

end
