require 'yaml'
require 'sequel'

env = ENV['MIDORI_ENV'] ? ENV['MIDORI_ENV'] : 'development'

task 'run' do
  ruby 'main.rb'
end

namespace :db do
  Sequel.extension :migration
  DB = Sequel.connect(YAML.load_file('config/db.yml')[env])

  desc 'Prints current schema version'
  task :version do
    version = if DB.tables.include?(:schema_info)
                DB[:schema_info].first[:version]
              end || 0

    puts "Schema Version: #{version}"
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end

  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback, :target do |_t, args|
    args.with_defaults(target: 0)

    Sequel::Migrator.run(DB, 'migrations', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel::Migrator.run(DB, 'migrations', target: 0)
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end
end
