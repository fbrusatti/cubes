require "sinatra/namespace"
require_relative '../middlewares/jwt_auth'

class Api < Sinatra::Application
  use JwtAuth
  register Sinatra::Namespace

  namespace '/v1' do
    get '/' do
      { response: 'text' }.to_json
    end
  end
end
