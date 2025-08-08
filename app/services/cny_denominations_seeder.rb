class CnyDenominationsSeeder
  def initialize
    @currency = Currency.find_by(code: 'CNY') || Currency.create!(
      code: 'CNY',
      name: 'Renminbi (Chinese Yuan)',
      country: 'China',
      description: 'People\'s Republic of China currency, modern series',
      is_active: true
    )
    @currency.update!(is_active: true) unless @currency.is_active?
  end

  def seed_all
    seed_cny_coins
    seed_cny_banknotes
  end

  private

  def upsert_denomination(attrs)
    existing = CurrencyDenomination.find_by(currency: @currency, name: attrs[:name], value: attrs[:value])
    if existing
      existing.update!(attrs.except(:value, :name).merge(currency: @currency))
    else
      CurrencyDenomination.create!(attrs.merge(currency: @currency))
    end
  end

  # Focus on Fourth/Fifth Series coins/notes commonly circulating
  def seed_cny_coins
    coins = [
      { name: '1 Jiao', value: 0.10, denomination_type: 'coin', year_introduced: 1980, year_discontinued: nil, composition: 'Aluminum/Steel (varies by year)', design_type: 'Orchid (4th)/Tiananmen (earlier)', series: '4th Series onwards', mint_mark: nil, is_active: true },
      { name: '5 Jiao', value: 0.50, denomination_type: 'coin', year_introduced: 1980, year_discontinued: nil, composition: 'Brass/Steel (varies)', design_type: 'Lotus (4th)/Tiananmen (earlier)', series: '4th Series onwards', mint_mark: nil, is_active: true },
      { name: '1 Yuan (coin)', value: 1.00, denomination_type: 'coin', year_introduced: 1999, year_discontinued: nil, composition: 'Nickel-plated steel', design_type: 'Orchid/1 Yuan', series: '5th Series', mint_mark: nil, is_active: true }
    ]
    coins.each { |a| upsert_denomination(a) }
  end

  def seed_cny_banknotes
    notes = [
      { name: '1 Yuan (note)', value: 1.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper', design_type: 'Mao Zedong (back: West Lake)', series: '5th Series', mint_mark: nil, is_active: true },
      { name: '5 Yuan (note)', value: 5.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper/Polymer (revisions)', design_type: 'Mao Zedong', series: '5th Series', mint_mark: nil, is_active: true },
      { name: '10 Yuan (note)', value: 10.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper', design_type: 'Mao Zedong', series: '5th Series', mint_mark: nil, is_active: true },
      { name: '20 Yuan (note)', value: 20.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper', design_type: 'Mao Zedong', series: '5th Series', mint_mark: nil, is_active: true },
      { name: '50 Yuan (note)', value: 50.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper', design_type: 'Mao Zedong', series: '5th Series', mint_mark: nil, is_active: true },
      { name: '100 Yuan (note)', value: 100.00, denomination_type: 'bill', year_introduced: 1999, year_discontinued: nil, composition: 'Paper', design_type: 'Mao Zedong', series: '5th Series', mint_mark: nil, is_active: true }
    ]
    notes.each { |a| upsert_denomination(a) }
  end
end
