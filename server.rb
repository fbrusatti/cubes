require 'bundler/setup'
require 'sinatra/base'
# require 'sinatra/reloader' if development?
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require "sinatra/activerecord"
require 'logger'

DEFAULT_GAME = {
  secret_1: nil,
  secret_2: nil,
  firings: [],
  player_1: nil,
  player_2: nil,
  turn: 1
}

class User < ActiveRecord::Base
  validates_presence_of :name
end

class App < Sinatra::Application
  register Sinatra::ActiveRecordExtension

  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      logger.info 'Reloaded!!!'
    end
  end

  def initialize(app = nil)
    super()
    @games = {}
  end

  get '/' do
    "Current games: #{@games}"
  end

  get '/users' do
    User.all.to_json
  end

  post '/games/new' do
    game_id = SecureRandom.base64(10)

    @games[game_id] = DEFAULT_GAME

    "/games/#{game_id}"
  end

  patch '/games/:id' do

  end
end

