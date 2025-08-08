namespace :db do
  namespace :seed do
    desc "Seed all ISO 4217 currencies (codes present but not in DB)"
    task iso4217: :environment do
      puts "Seeding ISO 4217 currencies..."
      Seeders::Iso4217CurrenciesSeeder.new.seed_all
      puts "Done. Total currencies: #{Currency.count}"
    end
  end
end

namespace :iso4217 do
  task seed: "db:seed:iso4217"
end


