namespace :soviet_denominations do
  desc "Seed Soviet (USSR) denomination variants"
  task seed: :environment do
    puts "Seeding Soviet denomination variants..."
    seeder = SovietDenominationsSeeder.new
    seeder.seed_all
    puts "Done."

    sur = Currency.find_by(code: 'SUR')
    counts = CurrencyDenomination.where(currency: sur).group(:denomination_type).count
    puts "Counts by type: #{counts.inspect}"
    puts "Total: #{CurrencyDenomination.where(currency: sur).count}"
  end
end
