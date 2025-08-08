class UsFractionalDenominationsSeeder
  def initialize
    @usd = Currency.find_by(code: 'USD')
    raise 'USD currency not found. Please seed USD first.' unless @usd
  end

  def seed_all
    seed_fractional_currency
  end

  private

  def upsert_denomination(attrs)
    existing = Currency.find_by(code: 'USD') && CurrencyDenomination.find_by(
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

  # U.S. Fractional Currency (a.k.a. Postal/Fractional Notes) 1862–1876
  # Denominations: 3¢, 5¢, 10¢, 15¢, 25¢, 50¢ across 5 issues
  def seed_fractional_currency
    notes = []

    # First Issue (Aug 1862 – May 1863)
    %w[3 5 10 25 50].each do |cents|
      notes << fractional_note(
        cents: cents,
        years: 1862..1863,
        series: 'Fractional Currency – First Issue',
        design: 'First Issue (perforated/straight edges, postage stamp motifs)'
      )
    end

    # Second Issue (Oct 1863 – Feb 1867)
    %w[5 10 25 50].each do |cents|
      notes << fractional_note(
        cents: cents,
        years: 1863..1867,
        series: 'Fractional Currency – Second Issue',
        design: 'Second Issue (bronzing, surcharges, George Washington et al.)'
      )
    end

    # Third Issue (Dec 1864 – Aug 1869)
    %w[3 5 10 25 50].each do |cents|
      notes << fractional_note(
        cents: cents,
        years: 1864..1869,
        series: 'Fractional Currency – Third Issue',
        design: 'Third Issue (red/green backs, surcharges, varied portraits)'
      )
    end

    # Fourth Issue (Jul 1869 – Feb 1875)
    %w[10 15 25 50].each do |cents|
      notes << fractional_note(
        cents: cents,
        years: 1869..1875,
        series: 'Fractional Currency – Fourth Issue',
        design: 'Fourth Issue (new portraits, small seal varieties)'
      )
    end

    # Fifth Issue (Feb 1874 – Feb 1876)
    %w[10 25 50].each do |cents|
      notes << fractional_note(
        cents: cents,
        years: 1874..1876,
        series: 'Fractional Currency – Fifth Issue',
        design: 'Fifth Issue (red/blue seals, different portraits)'
      )
    end

    notes.each { |attrs| upsert_denomination(attrs) }
  end

  def fractional_note(cents:, years:, series:, design:)
    value = (cents.to_i / 100.0).round(2)
    {
      name: "#{cents} Cents Fractional Note",
      value: value,
      denomination_type: 'bill',
      year_introduced: years.begin,
      year_discontinued: years.end,
      composition: 'Paper',
      design_type: design,
      series: series,
      mint_mark: nil,
      is_active: false
    }
  end
end
