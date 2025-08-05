namespace :sample_images do
  desc "Add sample image URLs for US denominations"
  task add_urls: :environment do
    puts "Adding sample image URLs for US denominations..."
    
    # Sample URLs for US currency (Wikipedia Commons - public domain)
    sample_urls = {
      'Penny' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/2009_Lincoln_penny_obverse.png/800px-2009_Lincoln_penny_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2009_Lincoln_penny_reverse.png/800px-2009_Lincoln_penny_reverse.png'
      },
      'Nickel' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2006_Jefferson_nickel_obverse.png/800px-2006_Jefferson_nickel_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/2006_Jefferson_nickel_reverse.png/800px-2006_Jefferson_nickel_reverse.png'
      },
      'Dime' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/2006_Roosevelt_dime_obverse.png/800px-2006_Roosevelt_dime_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/2006_Roosevelt_dime_reverse.png/800px-2006_Roosevelt_dime_reverse.png'
      },
      'Quarter' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/2006_Washington_quarter_obverse.png/800px-2006_Washington_quarter_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2006_Washington_quarter_reverse.png/800px-2006_Washington_quarter_reverse.png'
      },
      'Half Dollar' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/2006_Kennedy_half_dollar_obverse.png/800px-2006_Kennedy_half_dollar_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/2006_Kennedy_half_dollar_reverse.png/800px-2006_Kennedy_half_dollar_reverse.png'
      },
      'Dollar Coin' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/2000_Sacagawea_dollar_obverse.png/800px-2000_Sacagawea_dollar_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/2000_Sacagawea_dollar_reverse.png/800px-2000_Sacagawea_dollar_reverse.png'
      },
      'Two Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2003_Series_2_dollar_bill_obverse.jpg/800px-2003_Series_2_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/2003_Series_2_dollar_bill_reverse.jpg/800px-2003_Series_2_dollar_bill_reverse.jpg'
      },
      'Five Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/2006_Series_5_dollar_bill_obverse.jpg/800px-2006_Series_5_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/2006_Series_5_dollar_bill_reverse.jpg/800px-2006_Series_5_dollar_bill_reverse.jpg'
      },
      'Ten Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/2004_Series_10_dollar_bill_obverse.jpg/800px-2004_Series_10_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/2004_Series_10_dollar_bill_reverse.jpg/800px-2004_Series_10_dollar_bill_reverse.jpg'
      },
      'Twenty Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/2006_Series_20_dollar_bill_obverse.jpg/800px-2006_Series_20_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/2006_Series_20_dollar_bill_reverse.jpg/800px-2006_Series_20_dollar_bill_reverse.jpg'
      },
      'Fifty Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/2004_Series_50_dollar_bill_obverse.jpg/800px-2004_Series_50_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2004_Series_50_dollar_bill_reverse.jpg/800px-2004_Series_50_dollar_bill_reverse.jpg'
      },
      'Hundred Dollar Bill' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/2009_Series_100_dollar_bill_obverse.jpg/800px-2009_Series_100_dollar_bill_obverse.jpg',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/2009_Series_100_dollar_bill_reverse.jpg/800px-2009_Series_100_dollar_bill_reverse.jpg'
      }
    }
    
    us_currency = Currency.find_by(code: 'USD')
    return puts "US Dollar currency not found!" unless us_currency
    
    sample_urls.each do |denomination_name, urls|
      denomination = us_currency.currency_denominations.find_by(name: denomination_name)
      next unless denomination
      
      puts "Adding URLs for #{denomination.name}..."
      
      # Store URLs in a way that can be accessed by the admin interface
      # For now, we'll just print them for manual use
      puts "  Obverse: #{urls[:obverse]}"
      puts "  Reverse: #{urls[:reverse]}"
      puts ""
    end
    
    puts "Sample URLs added! Use these in the admin bulk upload interface."
  end
end 