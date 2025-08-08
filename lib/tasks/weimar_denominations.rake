namespace :db do
  namespace :seed do
    desc "Seed Weimar Republic currency denominations (Papiermark/Rentenmark)"
    task weimar_denominations: :environment do
      puts "Seeding Weimar Republic denominations..."
      WeimarDenominationsSeeder.new.seed_all
      puts "Done."
    end
  end
end

namespace :weimar_denominations do
  task seed: "db:seed:weimar_denominations"
end
