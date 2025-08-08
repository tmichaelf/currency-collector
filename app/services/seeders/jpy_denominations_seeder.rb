module Seeders
  class JpyDenominationsSeeder
    def initialize
      @currency = Currency.find_by(code: 'JPY') || Currency.create!(
        code: 'JPY',
        name: 'Japanese Yen',
        country: 'Japan',
        description: 'Modern Japanese Yen denominations',
        is_active: true
      )
      @currency.update!(is_active: true) unless @currency.is_active?
    end

    def seed_all
      seed_jpy_coins
      seed_jpy_banknotes
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

    def seed_jpy_coins
      coins = [
        { name: '1 Yen (coin)', value: 1.00, denomination_type: 'coin', year_introduced: 1955, year_discontinued: nil, composition: 'Aluminum', design_type: 'Young tree', series: 'Post-war', mint_mark: nil, is_active: true },
        { name: '5 Yen (coin)', value: 5.00, denomination_type: 'coin', year_introduced: 1959, year_discontinued: nil, composition: 'Brass', design_type: 'Rice/gear water (holed)', series: 'Post-war', mint_mark: nil, is_active: true },
        { name: '10 Yen (coin)', value: 10.00, denomination_type: 'coin', year_introduced: 1951, year_discontinued: nil, composition: 'Bronze', design_type: 'Byodo-in Phoenix Hall', series: 'Post-war', mint_mark: nil, is_active: true },
        { name: '50 Yen (coin)', value: 50.00, denomination_type: 'coin', year_introduced: 1967, year_discontinued: nil, composition: 'Cupronickel', design_type: 'Chrysanthemum (holed)', series: 'Post-war', mint_mark: nil, is_active: true },
        { name: '100 Yen (coin)', value: 100.00, denomination_type: 'coin', year_introduced: 1967, year_discontinued: nil, composition: 'Cupronickel', design_type: 'Sakura', series: 'Post-war', mint_mark: nil, is_active: true },
        { name: '500 Yen (coin)', value: 500.00, denomination_type: 'coin', year_introduced: 1982, year_discontinued: nil, composition: 'Nickel-brass (current: bi-metallic)', design_type: 'Paulownia/Anti-counterfeit', series: 'Modern', mint_mark: nil, is_active: true }
      ]
      coins.each { |a| upsert_denomination(a) }
    end

    def seed_jpy_banknotes
      notes = [
        { name: '1,000 Yen (note)', value: 1000.00, denomination_type: 'bill', year_introduced: 1984, year_discontinued: nil, composition: 'Paper', design_type: 'Natsume Soseki/Hideyo Noguchi', series: 'Series E/F', mint_mark: nil, is_active: true },
        { name: '2,000 Yen (note)', value: 2000.00, denomination_type: 'bill', year_introduced: 2000, year_discontinued: nil, composition: 'Paper', design_type: 'Shureimon Gate', series: 'Series D/E', mint_mark: nil, is_active: true },
        { name: '5,000 Yen (note)', value: 5000.00, denomination_type: 'bill', year_introduced: 2004, year_discontinued: nil, composition: 'Paper', design_type: 'Ichiyo Higuchi', series: 'Series E', mint_mark: nil, is_active: true },
        { name: '10,000 Yen (note)', value: 10000.00, denomination_type: 'bill', year_introduced: 2004, year_discontinued: nil, composition: 'Paper', design_type: 'Fukuzawa Yukichi', series: 'Series E', mint_mark: nil, is_active: true }
      ]
      notes.each { |a| upsert_denomination(a) }
    end
  end
end


