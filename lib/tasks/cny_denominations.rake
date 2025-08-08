namespace :db do
  namespace :seed do
    desc "Seed CNY (Renminbi) denominations"
    task cny_denominations: :environment do
      puts "Seeding CNY denominations..."
      CnyDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :cny_denominations do
  task seed: "db:seed:cny_denominations"
end
