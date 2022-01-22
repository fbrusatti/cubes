require 'jwt'

class Authentication < Sinatra::Application
  post "/" do
    content_type :json

    request.body.rewind
    @params = JSON.parse(request.body.read)

    @user = User.find_by(name: @params['name'])

    if @user && @user.password == @params['password']
      # Needed to use in web page?
      session[:user] = @user.id

      { token: jwt_token(@user) }.to_json
    else
      halt 401
    end
  end

  get "/logout" do
    session[:user] = session[:pass] = nil
  end

  private
  def jwt_token(user)
    token = JWT.encode payload(user), ENV['JWT_SECRET'], 'HS256'
  end

  def payload(user)
    {
      sub: user.id,
      exp: Time.now.to_i + 60 * 60,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER']
    }
  end
end

