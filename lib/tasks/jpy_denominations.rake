namespace :db do
  namespace :seed do
    desc "Seed JPY (Japanese Yen) denominations"
    task jpy_denominations: :environment do
      puts "Seeding JPY denominations..."
      JpyDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :jpy_denominations do
  task seed: "db:seed:jpy_denominations"
end
