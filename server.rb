require 'sinatra/base'

DEFAULT_GAME = {
  secret_1: nil,
  secret_2: nil,
  firings: []
}


class App < Sinatra::Application
  def initialize(app = nil)
    super()
    @games = {}
  end

  get '/' do
    'Welcome to 10 Cubes'
  end

  post '/games/new' do
    'Create Game'
    game_id = SecureRandom.base64(10)

    @games[game_id] = DEFAULT_GAME

    "/games/#{game_id}"
  end
end

