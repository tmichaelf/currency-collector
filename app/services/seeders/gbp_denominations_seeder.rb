module Seeders
  class GbpDenominationsSeeder
    def initialize
      @currency = Currency.find_by(code: 'GBP') || Currency.create!(
        code: 'GBP',
        name: 'Pound Sterling',
        country: 'United Kingdom',
        description: 'Decimal coinage (since 1971) and modern polymer notes',
        is_active: true
      )
      @currency.update!(is_active: true) unless @currency.is_active?
    end

    def seed_all
      seed_gbp_coins
      seed_gbp_banknotes
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

    def seed_gbp_coins
      coins = [
        { name: '1 Penny', value: 0.01, denomination_type: 'coin', year_introduced: 1971, year_discontinued: nil, composition: 'Bronze/Copper-plated steel', design_type: 'Portcullis/Shield (new design)', series: 'Decimalisation', mint_mark: nil, is_active: true },
        { name: '2 Pence', value: 0.02, denomination_type: 'coin', year_introduced: 1971, year_discontinued: nil, composition: 'Bronze/Copper-plated steel', design_type: 'Prince of Wales feathers/Shield', series: 'Decimalisation', mint_mark: nil, is_active: true },
        { name: '5 Pence', value: 0.05, denomination_type: 'coin', year_introduced: 1968, year_discontinued: nil, composition: 'Cupronickel/Nickel-plated steel', design_type: 'Crown/Shield', series: 'Decimalisation', mint_mark: nil, is_active: true },
        { name: '10 Pence', value: 0.10, denomination_type: 'coin', year_introduced: 1968, year_discontinued: nil, composition: 'Cupronickel/Nickel-plated steel', design_type: 'Lion/Shield', series: 'Decimalisation', mint_mark: nil, is_active: true },
        { name: '20 Pence', value: 0.20, denomination_type: 'coin', year_introduced: 1982, year_discontinued: nil, composition: 'Cupronickel', design_type: 'Tudor rose/Shield', series: 'Heptagonal', mint_mark: nil, is_active: true },
        { name: '50 Pence', value: 0.50, denomination_type: 'coin', year_introduced: 1969, year_discontinued: nil, composition: 'Cupronickel', design_type: 'Britannia/Shield', series: 'Heptagonal', mint_mark: nil, is_active: true },
        { name: 'One Pound (coin)', value: 1.00, denomination_type: 'coin', year_introduced: 2017, year_discontinued: nil, composition: 'Bi-metallic', design_type: '12-sided £1 coin', series: 'Security features', mint_mark: nil, is_active: true },
        { name: 'Two Pounds (coin)', value: 2.00, denomination_type: 'coin', year_introduced: 1998, year_discontinued: nil, composition: 'Bi-metallic', design_type: 'Technologies design', series: 'Modern', mint_mark: nil, is_active: true }
      ]
      coins.each { |a| upsert_denomination(a) }
    end

    def seed_gbp_banknotes
      notes = [
        { name: '£5 (polymer)', value: 5.00, denomination_type: 'bill', year_introduced: 2016, year_discontinued: nil, composition: 'Polymer', design_type: 'Winston Churchill', series: 'Polymer', mint_mark: nil, is_active: true },
        { name: '£10 (polymer)', value: 10.00, denomination_type: 'bill', year_introduced: 2017, year_discontinued: nil, composition: 'Polymer', design_type: 'Jane Austen', series: 'Polymer', mint_mark: nil, is_active: true },
        { name: '£20 (polymer)', value: 20.00, denomination_type: 'bill', year_introduced: 2020, year_discontinued: nil, composition: 'Polymer', design_type: 'J. M. W. Turner', series: 'Polymer', mint_mark: nil, is_active: true },
        { name: '£50 (polymer)', value: 50.00, denomination_type: 'bill', year_introduced: 2021, year_discontinued: nil, composition: 'Polymer', design_type: 'Alan Turing', series: 'Polymer', mint_mark: nil, is_active: true }
      ]
      notes.each { |a| upsert_denomination(a) }
    end
  end
end


