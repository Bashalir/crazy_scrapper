# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative './scrap.rb'

def get_currency_symbol(currencies_page, index)
  xpath_symbol = "//tbody/tr[#{index}]/td[3]"
  currency_symbol = scrap_element(currencies_page, xpath_symbol)
end

def get_currency_price(currencies_page, index)
  xpath_price = "//tbody/tr[#{index}]/td[5]"
  regexp_format_price = /[^$,]*/

  currency_price_raw = scrap_element(currencies_page, xpath_price)

  currency_price_formatted = currency_price_raw
                             .scan(regexp_format_price)
                             .join

  currency_price = currency_price_formatted.to_f
end

def get_currencies(currencies_page)
  currencies = []
  number_of_currency = 200

  (1..number_of_currency).each do |index|
    currency_symbol = get_currency_symbol(currencies_page, index)
    currency_price = get_currency_price(currencies_page, index)
    p currency = { currency_symbol => currency_price }
    currencies << currency
  end
  currencies
end

currencies_page = scrap_page('https://coinmarketcap.com/all/views/all/')

p get_currencies(currencies_page)
