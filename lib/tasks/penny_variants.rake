namespace :penny_variants do
  desc "Scrape and create all US penny variants"
  task scrape: :environment do
    puts "Starting US penny variant scraping..."
    
    service = PennyScraperService.new
    service.scrape_and_create_penny_variants
    
    puts "Penny variant scraping completed!"
    
    # Display summary
    penny_count = CurrencyDenomination.where(currency: Currency.find_by(code: 'USD'), value: 0.01).count
    puts "Total penny variants in database: #{penny_count}"
  end

  desc "List all penny variants in the database"
  task list: :environment do
    usd = Currency.find_by(code: 'USD')
    pennies = CurrencyDenomination.where(currency: usd, value: 0.01).order(:year_introduced)
    
    puts "US Penny Variants in Database:"
    puts "=" * 50
    
    pennies.each do |penny|
      status = penny.current? ? "Current" : "Discontinued"
      puts "#{penny.name}"
      puts "  Series: #{penny.series}"
      puts "  Design: #{penny.design_type}"
      puts "  Years: #{penny.year_introduced}-#{penny.year_discontinued || 'Present'}"
      puts "  Composition: #{penny.composition}"
      puts "  Mint Marks: #{penny.mint_mark || 'None'}"
      puts "  Status: #{status}"
      puts "-" * 30
    end
    
    puts "\nTotal: #{pennies.count} penny variants"
  end

  desc "Clean up penny variants (remove all pennies and re-scrape)"
  task clean: :environment do
    usd = Currency.find_by(code: 'USD')
    pennies = CurrencyDenomination.where(currency: usd, value: 0.01)
    
    puts "Removing #{pennies.count} existing penny variants..."
    pennies.destroy_all
    
    puts "Running penny scraper..."
    Rake::Task['penny_variants:scrape'].invoke
  end
end
