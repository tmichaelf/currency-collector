class SovietDenominationsSeeder
  def initialize
    @currency = Currency.find_by(code: 'SUR') || Currency.create!(
      code: 'SUR',
      name: 'Soviet Ruble',
      country: 'Union of Soviet Socialist Republics',
      description: 'Historic currency of the USSR (1917–1991)',
      is_active: true
    )
    @currency.update!(is_active: true) unless @currency.is_active?
  end

  def seed_all
    seed_soviet_coins
    seed_soviet_banknotes
  end

  private

  def upsert_denomination(attrs)
    record = CurrencyDenomination.find_by(currency: @currency, name: attrs[:name], value: attrs[:value])
    if record
      record.update!(attrs.except(:value, :name).merge(currency: @currency))
      :updated
    else
      CurrencyDenomination.create!(attrs.merge(currency: @currency))
      :created
    end
  end

  # Sources for ranges/series (curated summary):
  # - 1922–1923, 1924 early USSR kopeks and rubles
  # - 1937 and 1947 monetary reforms
  # - 1961–1991 circulating designs (most familiar Soviet coins/notes)
  def seed_soviet_coins
    coin_variants = []

    # Early issues (1924)
    coin_variants += [
      { name: '1 Kopek (1924 design)', value: 0.01, denomination_type: 'coin', year_introduced: 1924, year_discontinued: 1925, composition: 'Bronze', design_type: 'Wreath/State Emblem', series: 'Early USSR', mint_mark: nil, is_active: false },
      { name: '3 Kopeks (1924 design)', value: 0.03, denomination_type: 'coin', year_introduced: 1924, year_discontinued: 1926, composition: 'Bronze', design_type: 'Wreath/State Emblem', series: 'Early USSR', mint_mark: nil, is_active: false },
      { name: '10 Kopeks (1924 silver)', value: 0.10, denomination_type: 'coin', year_introduced: 1924, year_discontinued: 1927, composition: 'Silver .500', design_type: 'Hammer & Sickle/Emblem', series: 'Early USSR', mint_mark: nil, is_active: false },
      { name: '20 Kopeks (1924 silver)', value: 0.20, denomination_type: 'coin', year_introduced: 1924, year_discontinued: 1931, composition: 'Silver .500', design_type: 'Hammer & Sickle/Emblem', series: 'Early USSR', mint_mark: nil, is_active: false }
    ]

    # Pre-war aluminum-bronze/cupro-nickel (1930s)
    coin_variants += [
      { name: '5 Kopeks (pre-war)', value: 0.05, denomination_type: 'coin', year_introduced: 1935, year_discontinued: 1938, composition: 'Aluminum-bronze', design_type: 'Wreath/Emblem', series: 'Pre-war', mint_mark: nil, is_active: false },
      { name: '15 Kopeks (pre-war)', value: 0.15, denomination_type: 'coin', year_introduced: 1931, year_discontinued: 1935, composition: 'Cupro-nickel', design_type: 'Wreath/Emblem', series: 'Pre-war', mint_mark: nil, is_active: false }
    ]

    # Post-war and 1947 reform (new designs)
    coin_variants += [
      { name: '1 Kopek (1947 reform)', value: 0.01, denomination_type: 'coin', year_introduced: 1948, year_discontinued: 1961, composition: 'Aluminum-bronze', design_type: 'Emblem with 16 ribbons', series: '1947 Reform', mint_mark: nil, is_active: false },
      { name: '3 Kopeks (1947 reform)', value: 0.03, denomination_type: 'coin', year_introduced: 1948, year_discontinued: 1961, composition: 'Aluminum-bronze', design_type: 'Emblem with 16 ribbons', series: '1947 Reform', mint_mark: nil, is_active: false },
      { name: '10 Kopeks (post-war)', value: 0.10, denomination_type: 'coin', year_introduced: 1937, year_discontinued: 1961, composition: 'Cupro-nickel', design_type: 'Emblem variations', series: 'Post-war', mint_mark: nil, is_active: false }
    ]

    # 1961 monetary reform – standard circulating coins most people know
    coin_variants += [
      { name: '1 Kopek (1961–1991)', value: 0.01, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Aluminum-bronze', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '2 Kopeks (1961–1991)', value: 0.02, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Aluminum-bronze', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '3 Kopeks (1961–1991)', value: 0.03, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Aluminum-bronze', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '5 Kopeks (1961–1991)', value: 0.05, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Aluminum-bronze', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '10 Kopeks (1961–1991)', value: 0.10, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Cupro-nickel', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '15 Kopeks (1961–1991)', value: 0.15, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Cupro-nickel', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '20 Kopeks (1961–1991)', value: 0.20, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Cupro-nickel', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '50 Kopeks (1961–1991)', value: 0.50, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Cupro-nickel', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '1 Ruble (coin, 1961–1991)', value: 1.00, denomination_type: 'coin', year_introduced: 1961, year_discontinued: 1991, composition: 'Cupro-nickel', design_type: 'Coat of Arms, denomination within wreath', series: '1961 Series', mint_mark: nil, is_active: false }
    ]

    # Late USSR commemoratives excluded; focus is standard circulating types
    coin_variants.each { |attrs| upsert_denomination(attrs) }
  end

  def seed_soviet_banknotes
    notes = []

    # Early hyperinflation/transition (1922–1924) – summarized representations
    notes += [
      { name: '1 Ruble (1922–1923 State Treasury Note)', value: 1.00, denomination_type: 'bill', year_introduced: 1922, year_discontinued: 1923, composition: 'Paper', design_type: 'State Treasury Note', series: '1922–1923', mint_mark: nil, is_active: false },
      { name: '3 Rubles (1924)', value: 3.00, denomination_type: 'bill', year_introduced: 1924, year_discontinued: 1925, composition: 'Paper', design_type: 'Early USSR issue', series: '1924', mint_mark: nil, is_active: false }
    ]

    # 1937 series
    notes += [
      { name: '5 Rubles (1937 series)', value: 5.00, denomination_type: 'bill', year_introduced: 1937, year_discontinued: 1947, composition: 'Paper', design_type: '1937 design', series: '1937', mint_mark: nil, is_active: false },
      { name: '10 Rubles (1937 series)', value: 10.00, denomination_type: 'bill', year_introduced: 1937, year_discontinued: 1947, composition: 'Paper', design_type: '1937 design', series: '1937', mint_mark: nil, is_active: false }
    ]

    # 1947 monetary reform notes
    notes += [
      { name: '3 Rubles (1947 reform)', value: 3.00, denomination_type: 'bill', year_introduced: 1947, year_discontinued: 1961, composition: 'Paper', design_type: '1947 design', series: '1947 Reform', mint_mark: nil, is_active: false },
      { name: '25 Rubles (1947 reform)', value: 25.00, denomination_type: 'bill', year_introduced: 1947, year_discontinued: 1961, composition: 'Paper', design_type: '1947 design', series: '1947 Reform', mint_mark: nil, is_active: false }
    ]

    # 1961 series – most common modern Soviet notes
    notes += [
      { name: '1 Ruble (1961 series)', value: 1.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '3 Rubles (1961 series)', value: 3.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '5 Rubles (1961 series)', value: 5.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '10 Rubles (1961 series)', value: 10.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '25 Rubles (1961 series)', value: 25.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '50 Rubles (1961 series)', value: 50.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false },
      { name: '100 Rubles (1961 series)', value: 100.00, denomination_type: 'bill', year_introduced: 1961, year_discontinued: 1991, composition: 'Paper', design_type: '1961 design', series: '1961 Series', mint_mark: nil, is_active: false }
    ]

    # 1991 last USSR series
    notes += [
      { name: '200 Rubles (1991 series)', value: 200.00, denomination_type: 'bill', year_introduced: 1991, year_discontinued: 1992, composition: 'Paper', design_type: '1991 design', series: '1991 Series', mint_mark: nil, is_active: false },
      { name: '500 Rubles (1991 series)', value: 500.00, denomination_type: 'bill', year_introduced: 1991, year_discontinued: 1992, composition: 'Paper', design_type: '1991 design', series: '1991 Series', mint_mark: nil, is_active: false },
      { name: '1000 Rubles (1991 series)', value: 1000.00, denomination_type: 'bill', year_introduced: 1991, year_discontinued: 1992, composition: 'Paper', design_type: '1991 design', series: '1991 Series', mint_mark: nil, is_active: false }
    ]

    notes.each { |attrs| upsert_denomination(attrs) }
  end
end
