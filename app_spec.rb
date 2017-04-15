require File.dirname(__FILE__) + '/app.rb'
require File.dirname(__FILE__) + '/credit_class/credit.rb'

require 'rspec'
require 'rack/test'

set :environment, :test


describe 'Test application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'Shoul load home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'Shoul load Contact page' do
    get '/contacts'
    expect(last_response).to be_ok
  end

  it 'Shoul not load unreal page' do
    get '/unreal_page'
    expect(last_response).to_not be_ok
  end

end

describe 'Credit' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:credit) {Credit.new 20, 1000, 0, 2}
  let(:arr) { [0, 1111.1111, 1.0] }
  let(:sum_arr) { [[1, 2, 3, 4],[1, 2, 3, 4]] }
  let(:a) {0}
  let(:b) {0}

  it 'should be an instance of Credit' do
    credit.should be_an_instance_of Credit
  end

  it 'prety should prettify' do
    expect(credit.send(:prety, arr)).to eq([0, "11.11", "0.01"]) # для вызова private метода
  end

  it 'pogashenie_credita should return float' do
    expect(credit.send(:pogashenie_credita, 90, 30)).to eq(3.0) # для вызова private метода
  end

  it 'PS should return percent' do
    expect(credit.send(:ps, 20.0)).to eq(0.016666666666666666) # для вызова private метода
  end

  it 'p_annuitet should return value' do
    expect(credit.send(:p_annuitet, 100, 0.016666666666666666,10)).to eq(10.939384010755898) # для вызова private метода
  end

  it 'get_sum should return value' do
    expect(credit.send(:get_sum, sum_arr, a , b)).to eq(["6.00","8.00"]) # для вызова private метода
  end

  it 'np_standart should return value' do
    expect(credit.send(:np_standart, 100.0, 20)).to eq(1.666666666666667) # для вызова private метода
  end

  describe 'standart' do
    before {credit.standart}

    it 'should return graph' do
      expect(credit.rezult).to eq([[1, "500.00", "16.67", "516.67", "500.00"], [2, "500.00", "8.33", "508.33", "0.00"]])
    end

  end

  describe 'annuitet' do
    before {credit.annuitet}

    it 'should return graph' do
      expect(credit.rezult).to eq([[1, "495.87", "16.67", "512.53", "504.13"], [2, "504.13", "8.40", "512.53", "0.00"]])
    end

  end

end

