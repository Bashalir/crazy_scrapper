# frozen_string_literal: true

require_relative "../lib/dark_trader"

describe "Scrap the coinmarketcap page" do
  currencies_page = scrap_page("https://coinmarketcap.com/all/views/all/")
  currencies = get_currencies(currencies_page)

  it "should connection is accepted" do
    expect(currencies_page).not_to match(/ECONNREFUSED/)
  end
  it "should return a array" do
    expect(currencies).to be_an_instance_of(Array)
  end
  it "should return 200 length of array" do
    expect(currencies.length).to eq(200)
  end

  it "should return the first hash key 'BTC' with a float value" do
    expect(currencies[0].key?("BTC")).to eq(true)
  end
  it "should return the second hash key 'ETH'" do
    expect(currencies[1].key?("ETH")).to eq(true)
  end
  it "should return the third hash key 'USDT'" do
    expect(currencies[2].key?("USDT")).to eq(true)
  end
end
