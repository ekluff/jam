require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

require 'sinatra/base'

enable :sessions

helpers do

  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end

  def user
    return session[:user]
  end

end


before do
  cache_control :public, :no_cache
	cache_control :views, :no_cache
end

get '/' do
  erb(:index)
end

get '/users/:id' do
  id = params.fetch('id')
  @user = User.find(id)
  erb(:index)
end

post '/signup' do
  name = params.fetch('name')
  email = params.fetch('email')
  password = params.fetch('password')
  password_confirmation = params.fetch('password_confirmation')
  password_hash = BCrypt::Password.create(password)
  @user = User.create({:name => name, :email => email, :password => password_hash})
  if @user.save()
    redirect "/user/#{@user.id}"
  else
    erb(:errors)
  end
end

post '/login' do
  email = params.fetch("email")
  password = params.fetch("password")
  @user = User.find_by(:email => email)
  if @user.authenticate(password)
    session[:username] = @user
    redirect "/user/#{@user.id}"
  else
    erb(:errors)
  end
end

get '/logout' do
  session[:username] = nil
  redirect('/')
end

get '/jams' do
  @sessions = Session.all()
  erb(:jams)
end

# post '/jams/instruments' do
#   instrument_id = params.fetch('instrument_id').to_i()
#   instrument = Instrument.find(instrument_id)
#   @sessions_instrument = instrument.sessions()
#   redirect '/jams'
# end
