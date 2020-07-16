# frozen_string_literal: true

require_relative '../lib/cher_depute'

describe 'Scrap list of all deputies' do
  deputies_page = scrap_page('http://www2.assemblee-nationale.fr/deputes/liste/tableau')
  it 'should connection is accepted' do
    expect(deputies_page).not_to match(/ECONNREFUSED/)
  end
  it 'should return a String' do
    expect(get_deputy_url(deputies_page, 1)).to be_an_instance_of(String)
  end
  it "should return the url of the last deputy 'http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA267330'" do
    expect(get_deputy_url(deputies_page, 573)).to eq('http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA267330')
  end
end

describe 'Scrap element of deputy M. Michel Zumkeller' do
  page_deputy = scrap_page('http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA267330')
  deputies_page = scrap_page('http://www2.assemblee-nationale.fr/deputes/liste/tableau')
  it 'should connection is accepted' do
    expect(page_deputy).not_to match(/ECONNREFUSED/)
  end
  it "should return first name 'Zumkeller'" do
    expect(get_deputy_lastname(deputies_page, 573)).to eq('Zumkeller')
  end
  it "should return last name 'Michel'" do
    expect(get_deputy_firstname(deputies_page, 'Zumkeller', 573)).to eq('Michel')
  end
  it "should return mail 'michel.zumkeller@assemblee-nationale.fr'" do
    expect(get_deputy_mail(page_deputy)).to eq('michel.zumkeller@assemblee-nationale.fr')
  end
end
