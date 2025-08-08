namespace :db do
  namespace :seed do
    desc "Seed GBP (Pound Sterling) denominations"
    task gbp_denominations: :environment do
      puts "Seeding GBP denominations..."
      Seeders::GbpDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :gbp_denominations do
  task seed: "db:seed:gbp_denominations"
end
