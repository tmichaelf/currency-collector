namespace :db do
  namespace :seed do
    desc "Seed Russian Federation (RUB) denominations"
    task russian_federation_denominations: :environment do
      puts "Seeding Russian Federation denominations..."
      RussianFederationDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :russian_federation_denominations do
  task seed: "db:seed:russian_federation_denominations"
end
