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
  @user = User.find(params.fetch('id'))
  if session[:user] == @user
    @profile_owner
  end
  erb(:profile)
end


get '/signup' do
  erb(:signup)
end

get '/jams/create' do
  @instruments = Instrument.all
  erb(:jams_create)
end

# get '/users/test' do
#   @user = User.create({first_name: "Evan", last_name: "Clough", username: 'ekluff', phone: 9712480214, email: 'ec437@comcast.net', address: '17243 Fernwood Drive', city: 'Lake Oswego', state: 'OR', zip: 97034, password: '18181818'})
#   erb(:profile)
# end

post '/signup' do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  email = params.fetch('email')
  username = params.fetch('username')
  password = params.fetch('password')
  password_confirmation = params.fetch('password_confirmation')
  phone = params.fetch('phone').gsub(/([\D])/, "")
  address = params.fetch('address')
  city = params.fetch('city').capitalize
  state = params.fetch('state').upcase
  zip = params.fetch('zip').gsub(/([\D])/, "")
  if password != password_confirmation
    @password_confirmation_error
    erb(:errors)
  end
  password_hash = BCrypt::Password.create(password)
  @user = User.create({:first_name => first_name, :last_name => last_name, :email => email, :username => username, :password => password_hash, :phone => phone, :address => address, :city => city, :state => state, :zip => zip})
  if @user.save()
    redirect "/users/#{@user.id}"
  else
    erb(:errors)
  end
end

post '/login' do
  email = params.fetch("email")
  password = params.fetch("password")
  @user = User.find_by(:email => email)
  if @user.authenticate(password)
    session[:user] = @user
    redirect "/users/#{@user.id}"
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

get '/errors' do
  erb(:errors)
end

# post '/jams/instruments' do
#   instrument_id = params.fetch('instrument_id').to_i()
#   instrument = Instrument.find(instrument_id)
#   @sessions_instrument = instrument.sessions()
#   redirect '/jams'
# end
