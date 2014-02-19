require 'spec_helper'

require 'parse.rb'

describe Parse do

  it 'should return an email address' do
    return_array = Parse.parse_email('name@domain.com')
    expect(return_array).to eq(['name@domain.com'])
  end

  it 'should exclude addresses which contain no name and return Not Found' do
    return_array = Parse.parse_email('@domain.com')
    expect(return_array).to eq(['Not Found'])
  end

  it 'should exclude addresses which contain no @ and return Not Found' do
    return_array = Parse.parse_email('domain.com')
    expect(return_array).to eq(['Not Found'])
  end

  it 'should exclude addresses which contain no @ and return Not Found' do
    return_array = Parse.parse_email('name')
    expect(return_array).to eq(['Not Found'])
  end

  it 'should exclude addresses which contain no @ and return Not Found' do
    return_array = Parse.parse_email('namedomain.com')
    expect(return_array).to eq(['Not Found'])
  end

end
