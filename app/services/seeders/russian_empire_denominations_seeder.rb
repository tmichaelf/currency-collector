module Seeders
  class RussianEmpireDenominationsSeeder
    def initialize
      @currency = Currency.find_by(code: 'RUB_IMP') || Currency.create!(
        code: 'RUB_IMP',
        name: 'Imperial Russian Ruble',
        country: 'Russian Empire',
        description: 'Historic currency of the Russian Empire (pre-1917)',
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
      base = CurrencyDenomination.find_or_create_by!(
        currency: @currency,
        value: attrs[:value],
        denomination_type: attrs[:denomination_type]
      ) do |d|
        d.name = format('%<v>.2f %<t>s', v: attrs[:value], t: attrs[:denomination_type])
        d.is_active = true
      end

      variant = CurrencyDenominationVariant.find_by(currency_denomination: base, name: attrs[:name])
      if variant
        variant.update!(attrs.slice(:year_introduced, :year_discontinued, :mint_mark, :composition, :design_type, :series, :is_active))
      else
        CurrencyDenominationVariant.create!(
          { currency_denomination: base, name: attrs[:name] }
            .merge(attrs.slice(:year_introduced, :year_discontinued, :mint_mark, :composition, :design_type, :series, :is_active))
        )
      end
    end

    def seed_coins
      coins = [
        { name: '1 Kopek (copper)', value: 0.01, denomination_type: 'coin', year_introduced: 1796, year_discontinued: 1917, composition: 'Copper', design_type: 'Imperial monogram', series: 'Imperial', mint_mark: nil, is_active: false },
        { name: '10 Kopeks (silver)', value: 0.10, denomination_type: 'coin', year_introduced: 1802, year_discontinued: 1917, composition: 'Silver', design_type: 'Double-headed eagle', series: 'Imperial', mint_mark: nil, is_active: false },
        { name: '50 Kopeks (silver)', value: 0.50, denomination_type: 'coin', year_introduced: 1802, year_discontinued: 1917, composition: 'Silver', design_type: 'Double-headed eagle', series: 'Imperial', mint_mark: nil, is_active: false },
        { name: '1 Ruble (silver)', value: 1.00, denomination_type: 'coin', year_introduced: 1704, year_discontinued: 1917, composition: 'Silver', design_type: 'Tsar portrait/Eagle', series: 'Imperial', mint_mark: nil, is_active: false },
        { name: '5 Rubles (gold)', value: 5.00, denomination_type: 'coin', year_introduced: 1802, year_discontinued: 1917, composition: 'Gold', design_type: 'Tsar portrait/Eagle', series: 'Imperial', mint_mark: nil, is_active: false }
      ]
      coins.each { |a| upsert_denomination(a) }
    end

    def seed_banknotes
      notes = [
        { name: '3 Rubles (note)', value: 3.00, denomination_type: 'bill', year_introduced: 1905, year_discontinued: 1917, composition: 'Paper', design_type: 'Imperial eagle', series: 'Early 20th century', mint_mark: nil, is_active: false },
        { name: '25 Rubles (note)', value: 25.00, denomination_type: 'bill', year_introduced: 1909, year_discontinued: 1917, composition: 'Paper', design_type: 'Imperial eagle/ornament', series: 'Early 20th century', mint_mark: nil, is_active: false },
        { name: '100 Rubles (note)', value: 100.00, denomination_type: 'bill', year_introduced: 1909, year_discontinued: 1917, composition: 'Paper', design_type: 'Imperial eagle/ornament', series: 'Early 20th century', mint_mark: nil, is_active: false }
      ]
      notes.each { |a| upsert_denomination(a) }
    end
  end
end


