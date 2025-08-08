namespace :db do
  namespace :seed do
    desc "Seed Third Reich (Reichsmark) denominations"
    task third_reich_denominations: :environment do
      puts "Seeding Third Reich denominations..."
      ThirdReichDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

# Backwards-compatible alias
namespace :third_reich_denominations do
  task seed: "db:seed:third_reich_denominations"
end
