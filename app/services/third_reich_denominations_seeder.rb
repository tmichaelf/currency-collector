class ThirdReichDenominationsSeeder
  def initialize
    @currency = Currency.find_by(code: 'REICH') || Currency.create!(
      code: 'REICH',
      name: 'Reichsmark (Third Reich)',
      country: 'Germany (Third Reich)',
      description: 'Currency of Nazi Germany, circa 1933–1945',
      is_active: true
    )
    @currency.update!(is_active: true) unless @currency.is_active?
  end

  def seed_all
    seed_coins
    seed_banknotes
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

  # Representative circulating types; commemoratives excluded.
  def seed_coins
    coins = [
      { name: '1 Reichspfennig', value: 0.01, denomination_type: 'coin', year_introduced: 1936, year_discontinued: 1945, composition: 'Bronze/Aluminum-bronze (earlier); Zinc (wartime)', design_type: 'Eagle and swastika; Oak leaves', series: 'Reichspfennig', mint_mark: nil, is_active: false },
      { name: '2 Reichspfennig', value: 0.02, denomination_type: 'coin', year_introduced: 1936, year_discontinued: 1945, composition: 'Bronze/Aluminum-bronze; Zinc (wartime)', design_type: 'Eagle and swastika; Oak leaves', series: 'Reichspfennig', mint_mark: nil, is_active: false },
      { name: '5 Reichspfennig', value: 0.05, denomination_type: 'coin', year_introduced: 1936, year_discontinued: 1945, composition: 'Aluminum-bronze; Zinc (wartime)', design_type: 'Eagle and swastika; Oak leaves', series: 'Reichspfennig', mint_mark: nil, is_active: false },
      { name: '10 Reichspfennig', value: 0.10, denomination_type: 'coin', year_introduced: 1936, year_discontinued: 1945, composition: 'Aluminum-bronze; Zinc (wartime)', design_type: 'Eagle and swastika; Oak leaves', series: 'Reichspfennig', mint_mark: nil, is_active: false },
      { name: '50 Reichspfennig (aluminum)', value: 0.50, denomination_type: 'coin', year_introduced: 1939, year_discontinued: 1945, composition: 'Aluminum', design_type: 'Eagle and swastika', series: 'Reichspfennig', mint_mark: nil, is_active: false },
      { name: '1 Reichsmark (coin)', value: 1.00, denomination_type: 'coin', year_introduced: 1933, year_discontinued: 1939, composition: 'Silver (early); Nickel (later)', design_type: 'Eagle and swastika', series: 'Reichsmark', mint_mark: nil, is_active: false },
      { name: '2 Reichsmark (coin)', value: 2.00, denomination_type: 'coin', year_introduced: 1933, year_discontinued: 1939, composition: 'Silver', design_type: 'Eagle and swastika; varied portraits', series: 'Reichsmark', mint_mark: nil, is_active: false }
    ]
    coins.each { |a| upsert_denomination(a) }
  end

  def seed_banknotes
    notes = [
      { name: '1 Reichsmark (note)', value: 1.00, denomination_type: 'bill', year_introduced: 1937, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '2 Reichsmark (note)', value: 2.00, denomination_type: 'bill', year_introduced: 1937, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '5 Reichsmark (note)', value: 5.00, denomination_type: 'bill', year_introduced: 1934, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '10 Reichsmark (note)', value: 10.00, denomination_type: 'bill', year_introduced: 1933, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '20 Reichsmark (note)', value: 20.00, denomination_type: 'bill', year_introduced: 1939, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '50 Reichsmark (note)', value: 50.00, denomination_type: 'bill', year_introduced: 1933, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '100 Reichsmark (note)', value: 100.00, denomination_type: 'bill', year_introduced: 1935, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false },
      { name: '1,000 Reichsmark (note)', value: 1000.00, denomination_type: 'bill', year_introduced: 1936, year_discontinued: 1945, composition: 'Paper', design_type: 'Reichsbanknote', series: 'Reichsmark notes', mint_mark: nil, is_active: false }
    ]
    notes.each { |a| upsert_denomination(a) }
  end
end
