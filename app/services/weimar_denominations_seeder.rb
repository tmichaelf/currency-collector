class WeimarDenominationsSeeder
  def initialize
    @currency = Currency.find_by(code: 'WEIMAR') || Currency.create!(
      code: 'WEIMAR',
      name: 'Weimar Republic Currency',
      country: 'Germany',
      description: 'Papiermark (1918–1923), Rentenmark (1923–1924)',
      is_active: true
    )
    @currency.update!(is_active: true) unless @currency.is_active?
  end

  def seed_all
    seed_papiermark
    seed_rentenmark
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

  def seed_papiermark
    notes = [
      { name: '1,000 Mark (Papiermark)', value: 1000.00, denomination_type: 'bill', year_introduced: 1919, year_discontinued: 1923, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Papiermark', mint_mark: nil, is_active: false },
      { name: '1 Million Mark (Papiermark)', value: 1000000.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1923, composition: 'Paper', design_type: 'Hyperinflation issue', series: 'Papiermark', mint_mark: nil, is_active: false },
      { name: '100 Million Mark (Papiermark)', value: 100000000.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1923, composition: 'Paper', design_type: 'Hyperinflation issue', series: 'Papiermark', mint_mark: nil, is_active: false }
    ]
    notes.each { |a| upsert_denomination(a) }
  end

  def seed_rentenmark
    notes = [
      { name: '1 Rentenmark', value: 1.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false },
      { name: '2 Rentenmark', value: 2.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false },
      { name: '5 Rentenmark', value: 5.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false },
      { name: '10 Rentenmark', value: 10.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false },
      { name: '50 Rentenmark', value: 50.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false },
      { name: '100 Rentenmark', value: 100.00, denomination_type: 'bill', year_introduced: 1923, year_discontinued: 1924, composition: 'Paper', design_type: 'Rentenbank', series: 'Rentenmark', mint_mark: nil, is_active: false }
    ]
    notes.each { |a| upsert_denomination(a) }
  end
end
