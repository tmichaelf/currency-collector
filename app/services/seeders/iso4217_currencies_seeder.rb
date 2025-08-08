module Seeders
  class Iso4217CurrenciesSeeder
    # Minimal embedded ISO 4217 subset. If config/iso_4217_currencies.yml exists,
    # it will be used instead of this inline list.
    ISO_CURRENCIES_FALLBACK = [
      { code: 'AED', name: 'United Arab Emirates Dirham', country: 'United Arab Emirates' },
      { code: 'AFN', name: 'Afghan Afghani', country: 'Afghanistan' },
      { code: 'ALL', name: 'Albanian Lek', country: 'Albania' },
      { code: 'AMD', name: 'Armenian Dram', country: 'Armenia' },
      { code: 'ANG', name: 'Netherlands Antillean Guilder', country: 'Curaçao/Sint Maarten' },
      { code: 'AOA', name: 'Angolan Kwanza', country: 'Angola' },
      { code: 'ARS', name: 'Argentine Peso', country: 'Argentina' },
      { code: 'AUD', name: 'Australian Dollar', country: 'Australia' },
      { code: 'AWG', name: 'Aruban Florin', country: 'Aruba' },
      { code: 'AZN', name: 'Azerbaijani Manat', country: 'Azerbaijan' },
      { code: 'BAM', name: 'Bosnia and Herzegovina Convertible Mark', country: 'Bosnia and Herzegovina' },
      { code: 'BBD', name: 'Barbados Dollar', country: 'Barbados' },
      { code: 'BDT', name: 'Bangladeshi Taka', country: 'Bangladesh' },
      { code: 'BGN', name: 'Bulgarian Lev', country: 'Bulgaria' },
      { code: 'BHD', name: 'Bahraini Dinar', country: 'Bahrain' },
      { code: 'BIF', name: 'Burundian Franc', country: 'Burundi' },
      { code: 'BMD', name: 'Bermudian Dollar', country: 'Bermuda' },
      { code: 'BND', name: 'Brunei Dollar', country: 'Brunei Darussalam' },
      { code: 'BOB', name: 'Boliviano', country: 'Bolivia' },
      { code: 'BRL', name: 'Brazilian Real', country: 'Brazil' },
      { code: 'BSD', name: 'Bahamian Dollar', country: 'Bahamas' },
      { code: 'BTN', name: 'Bhutanese Ngultrum', country: 'Bhutan' },
      { code: 'BWP', name: 'Botswana Pula', country: 'Botswana' },
      { code: 'BYN', name: 'Belarusian Ruble', country: 'Belarus' },
      { code: 'BZD', name: 'Belize Dollar', country: 'Belize' },
      { code: 'CAD', name: 'Canadian Dollar', country: 'Canada' },
      { code: 'CDF', name: 'Congolese Franc', country: 'Congo (DRC)' },
      { code: 'CHF', name: 'Swiss Franc', country: 'Switzerland' },
      { code: 'CLP', name: 'Chilean Peso', country: 'Chile' },
      { code: 'CNY', name: 'Chinese Yuan', country: 'China' },
      { code: 'COP', name: 'Colombian Peso', country: 'Colombia' },
      { code: 'CRC', name: 'Costa Rican Colón', country: 'Costa Rica' },
      { code: 'CUP', name: 'Cuban Peso', country: 'Cuba' },
      { code: 'CVE', name: 'Cape Verdean Escudo', country: 'Cabo Verde' },
      { code: 'CZK', name: 'Czech Koruna', country: 'Czechia' },
      { code: 'DJF', name: 'Djiboutian Franc', country: 'Djibouti' },
      { code: 'DKK', name: 'Danish Krone', country: 'Denmark' },
      { code: 'DOP', name: 'Dominican Peso', country: 'Dominican Republic' },
      { code: 'DZD', name: 'Algerian Dinar', country: 'Algeria' },
      { code: 'EGP', name: 'Egyptian Pound', country: 'Egypt' },
      { code: 'ERN', name: 'Eritrean Nakfa', country: 'Eritrea' },
      { code: 'ETB', name: 'Ethiopian Birr', country: 'Ethiopia' },
      { code: 'EUR', name: 'Euro', country: 'European Union' },
      { code: 'FJD', name: 'Fiji Dollar', country: 'Fiji' },
      { code: 'FKP', name: 'Falkland Islands Pound', country: 'Falkland Islands' },
      { code: 'GBP', name: 'Pound Sterling', country: 'United Kingdom' },
      { code: 'GEL', name: 'Georgian Lari', country: 'Georgia' },
      { code: 'GHS', name: 'Ghanaian Cedi', country: 'Ghana' },
      { code: 'GIP', name: 'Gibraltar Pound', country: 'Gibraltar' },
      { code: 'GMD', name: 'Gambian Dalasi', country: 'Gambia' },
      { code: 'GNF', name: 'Guinean Franc', country: 'Guinea' },
      { code: 'GTQ', name: 'Guatemalan Quetzal', country: 'Guatemala' },
      { code: 'GYD', name: 'Guyanese Dollar', country: 'Guyana' },
      { code: 'HKD', name: 'Hong Kong Dollar', country: 'Hong Kong' },
      { code: 'HNL', name: 'Honduran Lempira', country: 'Honduras' },
      { code: 'HRK', name: 'Croatian Kuna', country: 'Croatia' },
      { code: 'HTG', name: 'Haitian Gourde', country: 'Haiti' },
      { code: 'HUF', name: 'Hungarian Forint', country: 'Hungary' },
      { code: 'IDR', name: 'Indonesian Rupiah', country: 'Indonesia' },
      { code: 'ILS', name: 'Israeli New Shekel', country: 'Israel' },
      { code: 'INR', name: 'Indian Rupee', country: 'India' },
      { code: 'IQD', name: 'Iraqi Dinar', country: 'Iraq' },
      { code: 'IRR', name: 'Iranian Rial', country: 'Iran' },
      { code: 'ISK', name: 'Icelandic Króna', country: 'Iceland' },
      { code: 'JMD', name: 'Jamaican Dollar', country: 'Jamaica' },
      { code: 'JOD', name: 'Jordanian Dinar', country: 'Jordan' },
      { code: 'JPY', name: 'Japanese Yen', country: 'Japan' },
      { code: 'KES', name: 'Kenyan Shilling', country: 'Kenya' },
      { code: 'KGS', name: 'Kyrgyzstani Som', country: 'Kyrgyzstan' },
      { code: 'KHR', name: 'Cambodian Riel', country: 'Cambodia' },
      { code: 'KMF', name: 'Comorian Franc', country: 'Comoros' },
      { code: 'KRW', name: 'South Korean Won', country: 'Korea (Republic of)' },
      { code: 'KWD', name: 'Kuwaiti Dinar', country: 'Kuwait' },
      { code: 'KYD', name: 'Cayman Islands Dollar', country: 'Cayman Islands' },
      { code: 'KZT', name: 'Kazakhstani Tenge', country: 'Kazakhstan' },
      { code: 'LAK', name: 'Lao Kip', country: 'Lao PDR' },
      { code: 'LBP', name: 'Lebanese Pound', country: 'Lebanon' },
      { code: 'LKR', name: 'Sri Lankan Rupee', country: 'Sri Lanka' },
      { code: 'LRD', name: 'Liberian Dollar', country: 'Liberia' },
      { code: 'LSL', name: 'Lesotho Loti', country: 'Lesotho' },
      { code: 'LYD', name: 'Libyan Dinar', country: 'Libya' },
      { code: 'MAD', name: 'Moroccan Dirham', country: 'Morocco' },
      { code: 'MDL', name: 'Moldovan Leu', country: 'Moldova' },
      { code: 'MGA', name: 'Malagasy Ariary', country: 'Madagascar' },
      { code: 'MKD', name: 'Macedonian Denar', country: 'North Macedonia' },
      { code: 'MMK', name: 'Myanmar Kyat', country: 'Myanmar' },
      { code: 'MNT', name: 'Mongolian Tögrög', country: 'Mongolia' },
      { code: 'MOP', name: 'Macanese Pataca', country: 'Macao' },
      { code: 'MRU', name: 'Mauritanian Ouguiya', country: 'Mauritania' },
      { code: 'MUR', name: 'Mauritian Rupee', country: 'Mauritius' },
      { code: 'MVR', name: 'Maldivian Rufiyaa', country: 'Maldives' },
      { code: 'MWK', name: 'Malawian Kwacha', country: 'Malawi' },
      { code: 'MXN', name: 'Mexican Peso', country: 'Mexico' },
      { code: 'MYR', name: 'Malaysian Ringgit', country: 'Malaysia' },
      { code: 'MZN', name: 'Mozambican Metical', country: 'Mozambique' },
      { code: 'NAD', name: 'Namibian Dollar', country: 'Namibia' },
      { code: 'NGN', name: 'Nigerian Naira', country: 'Nigeria' },
      { code: 'NIO', name: 'Nicaraguan Córdoba', country: 'Nicaragua' },
      { code: 'NOK', name: 'Norwegian Krone', country: 'Norway' },
      { code: 'NPR', name: 'Nepalese Rupee', country: 'Nepal' },
      { code: 'NZD', name: 'New Zealand Dollar', country: 'New Zealand' },
      { code: 'OMR', name: 'Omani Rial', country: 'Oman' },
      { code: 'PAB', name: 'Panamanian Balboa', country: 'Panama' },
      { code: 'PEN', name: 'Peruvian Sol', country: 'Peru' },
      { code: 'PGK', name: 'Papua New Guinean Kina', country: 'Papua New Guinea' },
      { code: 'PHP', name: 'Philippine Peso', country: 'Philippines' },
      { code: 'PKR', name: 'Pakistani Rupee', country: 'Pakistan' },
      { code: 'PLN', name: 'Polish Zloty', country: 'Poland' },
      { code: 'PYG', name: 'Paraguayan Guaraní', country: 'Paraguay' },
      { code: 'QAR', name: 'Qatari Riyal', country: 'Qatar' },
      { code: 'RON', name: 'Romanian Leu', country: 'Romania' },
      { code: 'RSD', name: 'Serbian Dinar', country: 'Serbia' },
      { code: 'RUB', name: 'Russian Ruble', country: 'Russian Federation' },
      { code: 'RWF', name: 'Rwandan Franc', country: 'Rwanda' },
      { code: 'SAR', name: 'Saudi Riyal', country: 'Saudi Arabia' },
      { code: 'SBD', name: 'Solomon Islands Dollar', country: 'Solomon Islands' },
      { code: 'SCR', name: 'Seychelles Rupee', country: 'Seychelles' },
      { code: 'SDG', name: 'Sudanese Pound', country: 'Sudan' },
      { code: 'SEK', name: 'Swedish Krona', country: 'Sweden' },
      { code: 'SGD', name: 'Singapore Dollar', country: 'Singapore' },
      { code: 'SLL', name: 'Sierra Leonean Leone', country: 'Sierra Leone' },
      { code: 'SOS', name: 'Somali Shilling', country: 'Somalia' },
      { code: 'SRD', name: 'Surinamese Dollar', country: 'Suriname' },
      { code: 'SSP', name: 'South Sudanese Pound', country: 'South Sudan' },
      { code: 'STN', name: 'São Tomé and Príncipe Dobra', country: 'São Tomé and Príncipe' },
      { code: 'SYP', name: 'Syrian Pound', country: 'Syrian Arab Republic' },
      { code: 'SZL', name: 'Eswatini Lilangeni', country: 'Eswatini' },
      { code: 'THB', name: 'Thai Baht', country: 'Thailand' },
      { code: 'TJS', name: 'Tajikistani Somoni', country: 'Tajikistan' },
      { code: 'TMT', name: 'Turkmenistan Manat', country: 'Turkmenistan' },
      { code: 'TND', name: 'Tunisian Dinar', country: 'Tunisia' },
      { code: 'TOP', name: 'Tongan Paʻanga', country: 'Tonga' },
      { code: 'TRY', name: 'Turkish Lira', country: 'Türkiye' },
      { code: 'TTD', name: 'Trinidad and Tobago Dollar', country: 'Trinidad and Tobago' },
      { code: 'TWD', name: 'New Taiwan Dollar', country: 'Taiwan' },
      { code: 'TZS', name: 'Tanzanian Shilling', country: 'Tanzania' },
      { code: 'UAH', name: 'Ukrainian Hryvnia', country: 'Ukraine' },
      { code: 'UGX', name: 'Ugandan Shilling', country: 'Uganda' },
      { code: 'USD', name: 'United States Dollar', country: 'United States' },
      { code: 'UYU', name: 'Uruguayan Peso', country: 'Uruguay' },
      { code: 'UZS', name: 'Uzbekistan Som', country: 'Uzbekistan' },
      { code: 'VES', name: 'Venezuelan Bolívar Soberano', country: 'Venezuela' },
      { code: 'VND', name: 'Vietnamese Đồng', country: 'Viet Nam' },
      { code: 'VUV', name: 'Vanuatu Vatu', country: 'Vanuatu' },
      { code: 'WST', name: 'Samoan Tālā', country: 'Samoa' },
      { code: 'XAF', name: 'CFA Franc BEAC', country: 'CEMAC' },
      { code: 'XCD', name: 'East Caribbean Dollar', country: 'OECS' },
      { code: 'XOF', name: 'CFA Franc BCEAO', country: 'UEMOA' },
      { code: 'XPF', name: 'CFP Franc', country: 'Collectivités d’outre-mer' },
      { code: 'YER', name: 'Yemeni Rial', country: 'Yemen' },
      { code: 'ZAR', name: 'South African Rand', country: 'South Africa' },
      { code: 'ZMW', name: 'Zambian Kwacha', country: 'Zambia' },
      { code: 'ZWL', name: 'Zimbabwean Dollar', country: 'Zimbabwe' }
    ].freeze

    def seed_all
      source_currencies.each do |row|
        upsert_currency(row)
      end
    end

    private

    def source_currencies
      money_currencies || yaml_currencies || ISO_CURRENCIES_FALLBACK
    end

    def money_currencies
      begin
        require 'money'
      rescue LoadError
        return nil
      end
      table = Money::Currency.table
      return nil unless table && table.is_a?(Hash)

      table.values.map do |entry|
        code = entry[:iso_code] || entry[:iso_alpha3] || entry[:iso_currency_code]
        name = entry[:name]
        countries = entry[:countries]
        next unless code && name
        {
          code: code.to_s.upcase,
          name: name.to_s,
          country: Array(countries).first || 'Multiple'
        }
      end.compact
    end

    def yaml_currencies
      path = Rails.root.join('config', 'iso_4217_currencies.yml')
      return nil unless File.exist?(path)
      data = YAML.safe_load(File.read(path))
      return data if data.is_a?(Array)
      nil
    end

    def upsert_currency(attrs)
      code = (attrs[:code] || attrs['code']).to_s.upcase.strip
      name = (attrs[:name] || attrs['name']).to_s.strip
      country = (attrs[:country] || attrs['country']).to_s.strip

      # Skip clearly invalid rows
      return :skipped if code.empty? || name.empty?
      country = 'Unknown' if country.empty?

      record = Currency.find_by(code: code)
      if record
        # Keep existing name/country/description if already present
        record.update!(is_active: true) unless record.is_active?
        return :updated
      end

      Currency.create!(
        code: code,
        name: name,
        country: country,
        description: name,
        is_active: true
      )
      :created
    end
  end
end


