require 'bundler/setup'
require 'sinatra/base'
# require 'sinatra/reloader' if development?
require 'sinatra/reloader' if Sinatra::Base.environment == :development

DEFAULT_GAME = {
  secret_1: nil,
  secret_2: nil,
  firings: []
}

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded!!!'
    end
  end

  def initialize(app = nil)
    super()
    @games = {}
  end

  get '/' do
    "Current games: #{@games}"
  end

  post '/games/new' do
    game_id = SecureRandom.base64(10)

    @games[game_id] = DEFAULT_GAME

    "/games/#{game_id}"
  end

  patch '/games/:id' do
  end
end

