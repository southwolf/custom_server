require 'bundler'
Bundler.require
require 'yaml'
require 'json'
require 'date'
require 'em-midori/extension/sequel'

Midori::Configure.before = proc do
  DATABASE = Sequel.connect(YAML.load_file('config/db.yml')['development'])
  Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
end

class Route < Midori::API
  get '/' do
    'Ohayou Midori'
  end
end

Midori::Runner.new(Route).start
