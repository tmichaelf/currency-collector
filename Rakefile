# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

# Also load tasks from db/tasks to colocate seeders with database concerns
Dir.glob("db/tasks/**/*.rake").each { |f| import f }

Rails.application.load_tasks
