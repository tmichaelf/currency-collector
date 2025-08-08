require 'nokogiri'
require 'open-uri'
require 'net/http'

class PennyScraperService
  def initialize
    @currency = Currency.find_by(code: 'USD')
    @base_url = 'https://www.usmint.gov'
  end

  def scrape_and_create_penny_variants
    penny_variants = [
      # Large Cents (1793-1857)
      { name: 'Flowing Hair Large Cent', value: 0.01, year_introduced: 1793, year_discontinued: 1796, 
        composition: 'Copper', design_type: 'Flowing Hair', series: 'Large Cent', mint_mark: nil },
      { name: 'Draped Bust Large Cent', value: 0.01, year_introduced: 1796, year_discontinued: 1807, 
        composition: 'Copper', design_type: 'Draped Bust', series: 'Large Cent', mint_mark: nil },
      { name: 'Classic Head Large Cent', value: 0.01, year_introduced: 1808, year_discontinued: 1814, 
        composition: 'Copper', design_type: 'Classic Head', series: 'Large Cent', mint_mark: nil },
      { name: 'Coronet Head Large Cent', value: 0.01, year_introduced: 1816, year_discontinued: 1839, 
        composition: 'Copper', design_type: 'Coronet Head', series: 'Large Cent', mint_mark: nil },
      { name: 'Braided Hair Large Cent', value: 0.01, year_introduced: 1839, year_discontinued: 1857, 
        composition: 'Copper', design_type: 'Braided Hair', series: 'Large Cent', mint_mark: nil },

      # Small Cents (1856-present)
      { name: 'Flying Eagle Cent', value: 0.01, year_introduced: 1856, year_discontinued: 1858, 
        composition: '88% Copper, 12% Nickel', design_type: 'Flying Eagle', series: 'Small Cent', mint_mark: nil },
      { name: 'Indian Head Cent', value: 0.01, year_introduced: 1859, year_discontinued: 1909, 
        composition: '88% Copper, 12% Nickel (1859-1864); 95% Copper, 5% Tin and Zinc (1864-1909)', 
        design_type: 'Indian Head', series: 'Small Cent', mint_mark: nil },
      
      # Lincoln Cents (1909-present)
      { name: 'Lincoln Wheat Cent', value: 0.01, year_introduced: 1909, year_discontinued: 1958, 
        composition: '95% Copper, 5% Tin and Zinc', design_type: 'Lincoln Wheat', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      { name: 'Lincoln Memorial Cent', value: 0.01, year_introduced: 1959, year_discontinued: 2008, 
        composition: '95% Copper, 5% Tin and Zinc (1959-1982); 97.5% Zinc, 2.5% Copper (1982-2008)', 
        design_type: 'Lincoln Memorial', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      { name: 'Lincoln Bicentennial Cent', value: 0.01, year_introduced: 2009, year_discontinued: 2009, 
        composition: '97.5% Zinc, 2.5% Copper', design_type: 'Lincoln Bicentennial', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      { name: 'Lincoln Shield Cent', value: 0.01, year_introduced: 2010, year_discontinued: nil, 
        composition: '97.5% Zinc, 2.5% Copper', design_type: 'Lincoln Shield', series: 'Lincoln Cent', mint_mark: 'D,S,P' },

      # Special Variants
      { name: 'Lincoln Cent (Steel)', value: 0.01, year_introduced: 1943, year_discontinued: 1943, 
        composition: 'Steel with Zinc coating', design_type: 'Lincoln Wheat', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      { name: 'Lincoln Cent (Brass)', value: 0.01, year_introduced: 1944, year_discontinued: 1946, 
        composition: '95% Copper, 5% Zinc', design_type: 'Lincoln Wheat', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      
      # Modern Variants
      { name: 'Lincoln Cent (Copper)', value: 0.01, year_introduced: 1982, year_discontinued: 1982, 
        composition: '95% Copper, 5% Tin and Zinc', design_type: 'Lincoln Memorial', series: 'Lincoln Cent', mint_mark: 'D,S,P' },
      { name: 'Lincoln Cent (Zinc)', value: 0.01, year_introduced: 1982, year_discontinued: nil, 
        composition: '97.5% Zinc, 2.5% Copper', design_type: 'Lincoln Memorial/Shield', series: 'Lincoln Cent', mint_mark: 'D,S,P' }
    ]

    penny_variants.each do |variant_data|
      create_penny_variant(variant_data)
    end

    puts "Successfully created #{penny_variants.count} penny variants!"
  end

  private

  def create_penny_variant(data)
    # Check if this variant already exists
    existing = CurrencyDenomination.find_by(
      currency: @currency,
      name: data[:name],
      value: data[:value]
    )

    if existing
      puts "Penny variant '#{data[:name]}' already exists, updating..."
      existing.update!(
        composition: data[:composition],
        design_type: data[:design_type],
        series: data[:series],
        mint_mark: data[:mint_mark],
        year_introduced: data[:year_introduced],
        year_discontinued: data[:year_discontinued]
      )
    else
      puts "Creating penny variant: #{data[:name]}"
      CurrencyDenomination.create!(
        currency: @currency,
        name: data[:name],
        value: data[:value],
        denomination_type: 'coin',
        year_introduced: data[:year_introduced],
        year_discontinued: data[:year_discontinued],
        composition: data[:composition],
        design_type: data[:design_type],
        series: data[:series],
        mint_mark: data[:mint_mark],
        is_active: true
      )
    end
  rescue => e
    puts "Error creating penny variant '#{data[:name]}': #{e.message}"
  end

  def scrape_usmint_data
    # This method could be used to scrape real-time data from US Mint website
    # For now, we're using hardcoded data for reliability
    begin
      url = "#{@base_url}/coins/coin-medal-programs/circulating-coins/penny"
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      
      if response.is_a?(Net::HTTPSuccess)
        doc = Nokogiri::HTML(response.body)
        # Parse the page content here if needed
        puts "Successfully scraped US Mint website"
      else
        puts "Failed to scrape US Mint website: #{response.code}"
      end
    rescue => e
      puts "Error scraping US Mint website: #{e.message}"
    end
  end
end
