namespace :db do
  namespace :seed do
    desc "Seed U.S. Fractional Currency (1862–1876) across all five issues"
    task us_fractional_denominations: :environment do
      puts "Seeding U.S. Fractional Currency..."
      seeder = UsFractionalDenominationsSeeder.new
      seeder.seed_all
      puts "Done."

      usd = Currency.find_by(code: 'USD')
      scope = CurrencyDenomination.where(currency: usd).where(value: [0.03, 0.05, 0.10, 0.15, 0.25, 0.50])
      counts = scope.group(:value).count
      puts "Inserted/updated fractional denominations: #{counts.inspect}"
      puts "Total fractional records: #{scope.count}"
    end
  end
end

# Alias for backward compatibility
namespace :us_fractional_denominations do
  task seed: "db:seed:us_fractional_denominations"
end
