# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative './scrap.rb'

def get_deputy_url(deputies_page, index)
  xpath_url = "//tbody/tr[#{index}]/td/a/attribute::href"

  began_path_url = 'http://www2.assemblee-nationale.fr'
  end_path_url = scrap_element(deputies_page, xpath_url)

  deputy_url = began_path_url + end_path_url
end

def get_deputy_lastname(deputies_page, index)
  xpath_lastname = "//tbody/tr[#{index}]/td/attribute::data-sort"
  depute_lastname = scrap_element(deputies_page, xpath_lastname)
end

def get_deputy_firstname(deputies_page, deputy_lastname, index)
  xpath_name = "//tbody/tr[#{index}]/td/a"
  deputy_fullname = scrap_element(deputies_page, xpath_name)

  fullname_split = deputy_fullname.split

  # delete civilite
  fullname_split.delete_at(0)
  # delete lastname
  fullname_split.delete(deputy_lastname)

  deputy_firstname = fullname_split[0]
end

def get_deputy_mail(page_deputy)
  xpath_mail = '//dt[text()="Contact"]/following-sibling::dd/ul/li[2]/a'
  deputy_mail = scrap_element(page_deputy, xpath_mail)
end

def get_deputies_info(deputies_page)
  number_of_deputy = 573
  deputies_info = []

  (1..number_of_deputy).each do |index|
    deputy_url = get_deputy_url(deputies_page, index)
    deputy_lastname = get_deputy_lastname(deputies_page, index)
    deputy_firstname = get_deputy_firstname(deputies_page, deputy_lastname, index)

    deputy_page = scrap_page(deputy_url)
    deputy_mail = get_deputy_mail(deputy_page)

    p deputy = { 'first_name' => deputy_firstname, 'last_name' => deputy_lastname, 'email' => deputy_mail }
    deputies_info << deputy
  end
  deputies_info
end

#deputies_page = scrap_page('http://www2.assemblee-nationale.fr/deputes/liste/tableau')
#p get_deputies_info(deputies_page)
