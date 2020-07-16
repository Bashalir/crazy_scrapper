# frozen_string_literal: true

require_relative '../lib/mairie_christmas'

describe 'Scrap all townhall of the val d oise' do
  townhalls_page = scrap_page('https://www.annuaire-des-mairies.com/val-d-oise.html')
  it 'should connection is accepted' do
    expect(townhalls_page).not_to match(/ECONNREFUSED/)
  end
  it 'should return a array' do
    expect(get_townhall_urls(townhalls_page)).to be_an_instance_of(Array)
  end
  it 'should return 185 length of array' do
    expect(get_townhall_urls(townhalls_page).length).to eq(185)
  end
end

describe 'Scrap element in the townhall of LE-PLESSIS-LUZARCHES' do
  townhall_url = scrap_page('https://www.annuaire-des-mairies.com/95/le-plessis-luzarches.html')
  it 'should connection is accepted' do
    expect(townhall_url).not_to match(/ECONNREFUSED/)
  end
  it "should return a 'mairieplessisluzarches@orange.fr'" do
    expect(get_townhall_email(townhall_url)).to eq('mairieplessisluzarches@orange.fr')
  end
  it "should return a 'LE-PLESSIS-LUZARCHES'" do
    expect(get_townhall_name(townhall_url)).to eq('LE-PLESSIS-LUZARCHES')
  end
end
