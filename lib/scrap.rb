# frozen_string_literal: true

def scrap_page(url)
  page = Nokogiri::HTML(URI.open(url))
end

def scrap_element(page, xpath)
  element = page.xpath(xpath).text
end
