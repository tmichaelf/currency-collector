module Seeders
  class RussianFederationDenominationsSeeder
    def initialize
      @currency = Currency.find_by(code: 'RUB') || Currency.create!(
        code: 'RUB',
        name: 'Russian Ruble',
        country: 'Russian Federation',
        description: 'Modern ruble (post-1992 reforms)',
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

    def seed_coins
      coins = [
        { name: '1 Kopek', value: 0.01, denomination_type: 'coin', year_introduced: 1997, year_discontinued: 2012, composition: 'Steel plated', design_type: 'St. George/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: false },
        { name: '5 Kopeks', value: 0.05, denomination_type: 'coin', year_introduced: 1997, year_discontinued: nil, composition: 'Nickel-plated steel', design_type: 'St. George/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: true },
        { name: '10 Kopeks', value: 0.10, denomination_type: 'coin', year_introduced: 1997, year_discontinued: nil, composition: 'Brass-plated steel', design_type: 'St. George/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: true },
        { name: '1 Ruble (coin)', value: 1.00, denomination_type: 'coin', year_introduced: 1997, year_discontinued: nil, composition: 'Nickel-plated steel', design_type: 'Floral/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: true },
        { name: '2 Rubles (coin)', value: 2.00, denomination_type: 'coin', year_introduced: 1997, year_discontinued: nil, composition: 'Nickel-plated steel', design_type: 'Floral/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: true },
        { name: '5 Rubles (coin)', value: 5.00, denomination_type: 'coin', year_introduced: 1997, year_discontinued: nil, composition: 'Nickel-plated steel', design_type: 'Floral/Coat of Arms', series: '1997 reform', mint_mark: nil, is_active: true },
        { name: '10 Rubles (bi-metallic coin)', value: 10.00, denomination_type: 'coin', year_introduced: 2000, year_discontinued: nil, composition: 'Bi-metallic', design_type: 'Bank of Russia', series: 'Commemoratives/general', mint_mark: nil, is_active: true }
      ]
      coins.each { |a| upsert_denomination(a) }
    end

    def seed_banknotes
      notes = [
        { name: '50 Rubles (note)', value: 50.00, denomination_type: 'bill', year_introduced: 1997, year_discontinued: nil, composition: 'Paper', design_type: 'St. Petersburg', series: '1997 series (revisions 2001/2004/2010)', mint_mark: nil, is_active: true },
        { name: '100 Rubles (note)', value: 100.00, denomination_type: 'bill', year_introduced: 1997, year_discontinued: nil, composition: 'Paper', design_type: 'Moscow/Bolshoi', series: '1997 series', mint_mark: nil, is_active: true },
        { name: '200 Rubles (note)', value: 200.00, denomination_type: 'bill', year_introduced: 2017, year_discontinued: nil, composition: 'Polymer/Paper hybrid', design_type: 'Sevastopol/Symbols', series: '2017 series', mint_mark: nil, is_active: true },
        { name: '500 Rubles (note)', value: 500.00, denomination_type: 'bill', year_introduced: 1997, year_discontinued: nil, composition: 'Paper', design_type: 'Arkhangelsk', series: '1997 series', mint_mark: nil, is_active: true },
        { name: '1,000 Rubles (note)', value: 1000.00, denomination_type: 'bill', year_introduced: 1997, year_discontinued: nil, composition: 'Paper', design_type: 'Yaroslavl', series: '1997 series', mint_mark: nil, is_active: true },
        { name: '2,000 Rubles (note)', value: 2000.00, denomination_type: 'bill', year_introduced: 2017, year_discontinued: nil, composition: 'Polymer/Paper hybrid', design_type: 'Far East bridge', series: '2017 series', mint_mark: nil, is_active: true },
        { name: '5,000 Rubles (note)', value: 5000.00, denomination_type: 'bill', year_introduced: 1997, year_discontinued: nil, composition: 'Paper', design_type: 'Khabarovsk', series: '1997 series', mint_mark: nil, is_active: true }
      ]
      notes.each { |a| upsert_denomination(a) }
    end
  end
end


