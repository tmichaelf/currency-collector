namespace :db do
  namespace :seed do
    desc "Seed Soviet (USSR) denomination variants"
    task soviet_denominations: :environment do
      puts "Seeding Soviet denomination variants..."
      seeder = Seeders::SovietDenominationsSeeder.new
      seeder.seed_all
      puts "Done."

      sur = Currency.find_by(code: 'SUR')
      counts = CurrencyDenomination.where(currency: sur).group(:denomination_type).count
      puts "Counts by type: #{counts.inspect}"
      puts "Total: #{CurrencyDenomination.where(currency: sur).count}"
    end
  end
end

# Backwards-compatible alias
namespace :soviet_denominations do
  task seed: "db:seed:soviet_denominations"
end
