require 'bundler'
Bundler.require

class Route < Midori::API
  get '/' do
    'Ohayou Midori'
  end
end

Midori::Runner.new(Route).start
