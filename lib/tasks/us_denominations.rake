namespace :us_denominations do
  desc "Seed all US denomination variants (coins and bills)"
  task seed: :environment do
    puts "Seeding all US denomination variants..."
    seeder = UsDenominationsSeeder.new
    seeder.seed_all
    puts "Done."

    usd = Currency.find_by(code: 'USD')
    counts = CurrencyDenomination.where(currency: usd).group(:denomination_type).count
    puts "Counts by type: #{counts.inspect}"
    puts "Total: #{CurrencyDenomination.where(currency: usd).count}"
  end
end
