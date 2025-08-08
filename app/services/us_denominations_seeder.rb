class UsDenominationsSeeder
  def initialize
    @usd = Currency.find_by(code: 'USD')
    raise 'USD currency not found. Seed USD first.' unless @usd
    @usd.update!(is_active: true) unless @usd.is_active?
  end

  def seed_all
    seed_us_coins
    seed_us_bills
  end

  private

  def upsert_denomination(attrs)
    existing = CurrencyDenomination.find_by(
      currency: @usd,
      name: attrs[:name],
      value: attrs[:value]
    )

    if existing
      existing.update!(attrs.except(:value, :name).merge(currency: @usd))
      :updated
    else
      CurrencyDenomination.create!(attrs.merge(currency: @usd))
      :created
    end
  end

  def seed_us_coins
    coin_variants = []

    # Cents (pennies)
    coin_variants += [
      { name: 'Flowing Hair Large Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1793, year_discontinued: 1796, composition: 'Copper', design_type: 'Flowing Hair', series: 'Large Cent', mint_mark: nil, is_active: false },
      { name: 'Draped Bust Large Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1796, year_discontinued: 1807, composition: 'Copper', design_type: 'Draped Bust', series: 'Large Cent', mint_mark: nil, is_active: false },
      { name: 'Classic Head Large Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1808, year_discontinued: 1814, composition: 'Copper', design_type: 'Classic Head', series: 'Large Cent', mint_mark: nil, is_active: false },
      { name: 'Coronet Head Large Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1816, year_discontinued: 1839, composition: 'Copper', design_type: 'Coronet Head', series: 'Large Cent', mint_mark: nil, is_active: false },
      { name: 'Braided Hair Large Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1839, year_discontinued: 1857, composition: 'Copper', design_type: 'Braided Hair', series: 'Large Cent', mint_mark: nil, is_active: false },
      { name: 'Flying Eagle Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1856, year_discontinued: 1858, composition: '88% Copper, 12% Nickel', design_type: 'Flying Eagle', series: 'Small Cent', mint_mark: nil, is_active: false },
      { name: 'Indian Head Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1859, year_discontinued: 1909, composition: 'CuNi 1859–1864; Bronze 1864–1909', design_type: 'Indian Head', series: 'Small Cent', mint_mark: nil, is_active: false },
      { name: 'Lincoln Wheat Cent', value: 0.01, denomination_type: 'coin', year_introduced: 1909, year_discontinued: 1958, composition: 'Bronze', design_type: 'Lincoln Wheat', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: false },
      { name: 'Lincoln Cent (Steel)', value: 0.01, denomination_type: 'coin', year_introduced: 1943, year_discontinued: 1943, composition: 'Zinc-coated steel', design_type: 'Lincoln Wheat', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: false },
      { name: 'Lincoln Memorial Cent (Bronze)', value: 0.01, denomination_type: 'coin', year_introduced: 1959, year_discontinued: 1982, composition: 'Bronze', design_type: 'Lincoln Memorial', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: false },
      { name: 'Lincoln Memorial Cent (Zinc)', value: 0.01, denomination_type: 'coin', year_introduced: 1982, year_discontinued: 2008, composition: 'Copper-plated zinc', design_type: 'Lincoln Memorial', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: false },
      { name: 'Lincoln Bicentennial Cent', value: 0.01, denomination_type: 'coin', year_introduced: 2009, year_discontinued: 2009, composition: 'Copper-plated zinc', design_type: '4 reverse designs', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: false },
      { name: 'Lincoln Shield Cent', value: 0.01, denomination_type: 'coin', year_introduced: 2010, year_discontinued: nil, composition: 'Copper-plated zinc', design_type: 'Shield', series: 'Lincoln Cent', mint_mark: 'P,D,S', is_active: true }
    ]

    # Nickels
    coin_variants += [
      { name: 'Shield Nickel', value: 0.05, denomination_type: 'coin', year_introduced: 1866, year_discontinued: 1883, composition: 'CuNi', design_type: 'Shield', series: 'Nickel', mint_mark: 'P', is_active: false },
      { name: 'Liberty Head Nickel', value: 0.05, denomination_type: 'coin', year_introduced: 1883, year_discontinued: 1912, composition: 'CuNi', design_type: 'Liberty Head', series: 'Nickel', mint_mark: 'P', is_active: false },
      { name: 'Buffalo Nickel', value: 0.05, denomination_type: 'coin', year_introduced: 1913, year_discontinued: 1938, composition: 'CuNi', design_type: 'Indian/Buffalo', series: 'Nickel', mint_mark: 'P,D,S', is_active: false },
      { name: 'Jefferson Nickel (CuNi)', value: 0.05, denomination_type: 'coin', year_introduced: 1938, year_discontinued: nil, composition: 'CuNi', design_type: 'Jefferson', series: 'Nickel', mint_mark: 'P,D,S', is_active: true },
      { name: 'Jefferson Nickel (Wartime Silver)', value: 0.05, denomination_type: 'coin', year_introduced: 1942, year_discontinued: 1945, composition: '35% silver, 56% copper, 9% manganese', design_type: 'Jefferson', series: 'Nickel', mint_mark: 'P,D,S', is_active: false }
    ]

    # Dimes
    coin_variants += [
      { name: 'Draped Bust Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1796, year_discontinued: 1807, composition: 'Silver', design_type: 'Draped Bust', series: 'Dime', mint_mark: nil, is_active: false },
      { name: 'Capped Bust Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1809, year_discontinued: 1837, composition: 'Silver', design_type: 'Capped Bust', series: 'Dime', mint_mark: nil, is_active: false },
      { name: 'Seated Liberty Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1837, year_discontinued: 1891, composition: 'Silver', design_type: 'Seated Liberty', series: 'Dime', mint_mark: nil, is_active: false },
      { name: 'Barber Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1892, year_discontinued: 1916, composition: 'Silver', design_type: 'Barber', series: 'Dime', mint_mark: 'P,D,S', is_active: false },
      { name: 'Mercury Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1916, year_discontinued: 1945, composition: '90% silver', design_type: 'Winged Liberty', series: 'Dime', mint_mark: 'P,D,S', is_active: false },
      { name: 'Roosevelt Dime (Silver)', value: 0.10, denomination_type: 'coin', year_introduced: 1946, year_discontinued: 1964, composition: '90% silver', design_type: 'Roosevelt', series: 'Dime', mint_mark: 'P,D,S', is_active: false },
      { name: 'Roosevelt Dime (Clad)', value: 0.10, denomination_type: 'coin', year_introduced: 1965, year_discontinued: nil, composition: 'Copper-nickel clad', design_type: 'Roosevelt', series: 'Dime', mint_mark: 'P,D,S,W (proofs)', is_active: true }
    ]

    # Quarters
    coin_variants += [
      { name: 'Draped Bust Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1796, year_discontinued: 1807, composition: 'Silver', design_type: 'Draped Bust', series: 'Quarter', mint_mark: nil, is_active: false },
      { name: 'Capped Bust Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1815, year_discontinued: 1838, composition: 'Silver', design_type: 'Capped Bust', series: 'Quarter', mint_mark: nil, is_active: false },
      { name: 'Seated Liberty Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1838, year_discontinued: 1891, composition: 'Silver', design_type: 'Seated Liberty', series: 'Quarter', mint_mark: nil, is_active: false },
      { name: 'Barber Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1892, year_discontinued: 1916, composition: 'Silver', design_type: 'Barber', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'Standing Liberty Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1916, year_discontinued: 1930, composition: '90% silver', design_type: 'Standing Liberty', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'Washington Quarter (Silver)', value: 0.25, denomination_type: 'coin', year_introduced: 1932, year_discontinued: 1964, composition: '90% silver', design_type: 'Washington', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'Washington Quarter (Clad)', value: 0.25, denomination_type: 'coin', year_introduced: 1965, year_discontinued: 1998, composition: 'Copper-nickel clad', design_type: 'Washington', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: '50 State Quarters', value: 0.25, denomination_type: 'coin', year_introduced: 1999, year_discontinued: 2008, composition: 'Copper-nickel clad', design_type: 'Various states', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'D.C. and U.S. Territories Quarters', value: 0.25, denomination_type: 'coin', year_introduced: 2009, year_discontinued: 2009, composition: 'Copper-nickel clad', design_type: 'DC & Territories', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'America the Beautiful Quarters', value: 0.25, denomination_type: 'coin', year_introduced: 2010, year_discontinued: 2021, composition: 'Copper-nickel clad', design_type: 'National Parks', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'Washington Crossing the Delaware Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 2021, year_discontinued: 2021, composition: 'Copper-nickel clad', design_type: 'Washington Crossing the Delaware', series: 'Quarter', mint_mark: 'P,D,S', is_active: false },
      { name: 'American Women Quarters', value: 0.25, denomination_type: 'coin', year_introduced: 2022, year_discontinued: nil, composition: 'Copper-nickel clad', design_type: 'American Women series', series: 'Quarter', mint_mark: 'P,D,S', is_active: true }
    ]

    # Half Dollars
    coin_variants += [
      { name: 'Flowing Hair Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1794, year_discontinued: 1795, composition: 'Silver', design_type: 'Flowing Hair', series: 'Half Dollar', mint_mark: nil, is_active: false },
      { name: 'Draped Bust Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1796, year_discontinued: 1807, composition: 'Silver', design_type: 'Draped Bust', series: 'Half Dollar', mint_mark: nil, is_active: false },
      { name: 'Capped Bust Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1807, year_discontinued: 1839, composition: 'Silver', design_type: 'Capped Bust', series: 'Half Dollar', mint_mark: nil, is_active: false },
      { name: 'Seated Liberty Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1839, year_discontinued: 1891, composition: 'Silver', design_type: 'Seated Liberty', series: 'Half Dollar', mint_mark: nil, is_active: false },
      { name: 'Barber Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1892, year_discontinued: 1915, composition: 'Silver', design_type: 'Barber', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Walking Liberty Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1916, year_discontinued: 1947, composition: '90% silver', design_type: 'Walking Liberty', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Franklin Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1948, year_discontinued: 1963, composition: '90% silver', design_type: 'Franklin', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Kennedy Half Dollar (Silver)', value: 0.50, denomination_type: 'coin', year_introduced: 1964, year_discontinued: 1964, composition: '90% silver', design_type: 'Kennedy', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Kennedy Half Dollar (40% Silver)', value: 0.50, denomination_type: 'coin', year_introduced: 1965, year_discontinued: 1970, composition: '40% silver', design_type: 'Kennedy', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Kennedy Half Dollar (Clad)', value: 0.50, denomination_type: 'coin', year_introduced: 1971, year_discontinued: nil, composition: 'Copper-nickel clad', design_type: 'Kennedy', series: 'Half Dollar', mint_mark: 'P,D,S', is_active: true }
    ]

    # Dollar Coins
    coin_variants += [
      { name: 'Flowing Hair Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1794, year_discontinued: 1795, composition: 'Silver', design_type: 'Flowing Hair', series: 'Dollar', mint_mark: nil, is_active: false },
      { name: 'Draped Bust Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1795, year_discontinued: 1804, composition: 'Silver', design_type: 'Draped Bust', series: 'Dollar', mint_mark: nil, is_active: false },
      { name: 'Gobrecht Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1836, year_discontinued: 1839, composition: 'Silver', design_type: 'Gobrecht', series: 'Dollar', mint_mark: nil, is_active: false },
      { name: 'Seated Liberty Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1840, year_discontinued: 1873, composition: 'Silver', design_type: 'Seated Liberty', series: 'Dollar', mint_mark: nil, is_active: false },
      { name: 'Trade Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1873, year_discontinued: 1885, composition: 'Silver', design_type: 'Trade', series: 'Dollar', mint_mark: nil, is_active: false },
      { name: 'Morgan Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1878, year_discontinued: 1904, composition: 'Silver', design_type: 'Morgan', series: 'Dollar', mint_mark: 'P,CC,S,O,D', is_active: false },
      { name: 'Peace Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1921, year_discontinued: 1935, composition: 'Silver', design_type: 'Peace', series: 'Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Eisenhower Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1971, year_discontinued: 1978, composition: 'Clad; some 40% silver', design_type: 'Eisenhower', series: 'Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Susan B. Anthony Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 1979, year_discontinued: 1981, composition: 'CuNi clad', design_type: 'Susan B. Anthony', series: 'Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'Sacagawea/Native American Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 2000, year_discontinued: nil, composition: 'Manganese-brass', design_type: 'Sacagawea/Native American', series: 'Dollar', mint_mark: 'P,D,S', is_active: true },
      { name: 'Presidential Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 2007, year_discontinued: 2016, composition: 'Manganese-brass', design_type: 'Presidential series', series: 'Dollar', mint_mark: 'P,D,S', is_active: false },
      { name: 'American Innovation Dollar', value: 1.00, denomination_type: 'coin', year_introduced: 2018, year_discontinued: nil, composition: 'Manganese-brass', design_type: 'Innovation series', series: 'Dollar', mint_mark: 'P,D,S', is_active: true }
    ]

    coin_variants.each { |attrs| upsert_denomination(attrs) }
  end

  def seed_us_bills
    bill_variants = []

    # $1
    bill_variants += [
      { name: 'One Dollar Bill (Large Size)', value: 1.00, denomination_type: 'bill', year_introduced: 1862, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Silver Certificate', mint_mark: nil, is_active: false },
      { name: 'One Dollar Bill (Small Size, Silver Certificate)', value: 1.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: 1963, composition: 'Paper', design_type: 'Silver Certificate', series: 'Small Size', mint_mark: nil, is_active: false },
      { name: 'One Dollar Bill (Small Size, Federal Reserve Note)', value: 1.00, denomination_type: 'bill', year_introduced: 1963, year_discontinued: nil, composition: 'Paper', design_type: 'Washington, FRN', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $2
    bill_variants += [
      { name: 'Two Dollar Bill (Large Size)', value: 2.00, denomination_type: 'bill', year_introduced: 1862, year_discontinued: 1918, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note', mint_mark: nil, is_active: false },
      { name: 'Two Dollar Bill (Small Size, United States Note)', value: 2.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: 1966, composition: 'Paper', design_type: 'United States Note', series: 'Small Size', mint_mark: nil, is_active: false },
      { name: 'Two Dollar Bill (Small Size, Federal Reserve Note)', value: 2.00, denomination_type: 'bill', year_introduced: 1976, year_discontinued: nil, composition: 'Paper', design_type: 'Jefferson, FRN', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $5
    bill_variants += [
      { name: 'Five Dollar Bill (Large Size)', value: 5.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Silver Certificate', mint_mark: nil, is_active: false },
      { name: 'Five Dollar Bill (Small Size)', value: 5.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: nil, composition: 'Paper', design_type: 'Lincoln, FRN (various redesigns 1999–2008)', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $10
    bill_variants += [
      { name: 'Ten Dollar Bill (Large Size)', value: 10.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Gold Certificate', mint_mark: nil, is_active: false },
      { name: 'Ten Dollar Bill (Small Size)', value: 10.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: nil, composition: 'Paper', design_type: 'Hamilton, FRN (redesigns 2000–2006)', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $20
    bill_variants += [
      { name: 'Twenty Dollar Bill (Large Size)', value: 20.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Gold Certificate', mint_mark: nil, is_active: false },
      { name: 'Twenty Dollar Bill (Small Size)', value: 20.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: nil, composition: 'Paper', design_type: 'Jackson, FRN (redesigns 1998–2003)', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $50
    bill_variants += [
      { name: 'Fifty Dollar Bill (Large Size)', value: 50.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Gold Certificate', mint_mark: nil, is_active: false },
      { name: 'Fifty Dollar Bill (Small Size)', value: 50.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: nil, composition: 'Paper', design_type: 'Grant, FRN (redesigns 1997–2004)', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    # $100
    bill_variants += [
      { name: 'One Hundred Dollar Bill (Large Size)', value: 100.00, denomination_type: 'bill', year_introduced: 1862, year_discontinued: 1928, composition: 'Paper', design_type: 'Various (Large Size Notes)', series: 'United States Note/Gold Certificate', mint_mark: nil, is_active: false },
      { name: 'One Hundred Dollar Bill (Small Size)', value: 100.00, denomination_type: 'bill', year_introduced: 1928, year_discontinued: nil, composition: 'Paper', design_type: 'Franklin, FRN (redesigns incl. 2009A)', series: 'Small Size', mint_mark: nil, is_active: true }
    ]

    bill_variants.each { |attrs| upsert_denomination(attrs) }
  end
end
