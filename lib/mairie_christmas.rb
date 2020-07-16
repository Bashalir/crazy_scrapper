# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require_relative "./scrap.rb"

def get_townhall_urls(townhalls_page)
  townhall_urls = []

  xpath_townhall = '//a[contains(@class,"lientxt")]/attribute::href'
  began_path_url = "https://www.annuaire-des-mairies.com"
  regexp_format_url = /\./

  end_path_urls = townhalls_page.xpath(xpath_townhall)

  end_path_urls.each do |end_path_url|
    townhall_url_raw = end_path_url.text
    townhall_url = townhall_url_raw.sub(regexp_format_url, began_path_url)

    townhall_urls << townhall_url
  end

  townhall_urls
end

def get_townhall_email(townhall_url)
  townhall_email = scrap_element(townhall_url, '//td[text()="Adresse Email"]/following-sibling::*')
end

def get_townhall_name(townhall_url)
  townhall_name = scrap_element(townhall_url, "(//a[@class='lientxt4'])[1]")
end

def get_townhall_contacts(townhalls_page)
  townhall_contacts = []
  townhall_urls = get_townhall_urls(townhalls_page)

  townhall_urls.each do |townhall_url|
    townhall_page = scrap_page(townhall_url)
    townhall_name = get_townhall_name(townhall_page)
    townhall_email = get_townhall_email(townhall_page)
    p townhall_contact = { townhall_name => townhall_email }
    townhall_contacts << townhall_contact
  end
  townhall_contacts
end

townhalls_page = scrap_page("https://www.annuaire-des-mairies.com/val-d-oise.html")
p get_townhall_contacts(townhalls_page)
