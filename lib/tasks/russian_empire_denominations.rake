namespace :db do
  namespace :seed do
    desc "Seed Imperial Russian Ruble denominations"
    task russian_empire_denominations: :environment do
      puts "Seeding Imperial Russian Ruble denominations..."
      Seeders::RussianEmpireDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :russian_empire_denominations do
  task seed: "db:seed:russian_empire_denominations"
end
