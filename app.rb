require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

require 'sinatra/base'

enable :sessions

helpers do

  def login?
    if session[:user].nil?
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
  if session[:user].id == @user.id
    @profile_owner = true
  end
  erb(:profile)
end

# patch '/users/:id/image/change' do
#   # def update
#   #   @user = user.update(params[:user])
#   # end
#
#   def create
#     @user = user.create(params[:user])
#   end
#
#   id = params.fetch('id')
#   user = User.find(id)
#   image = params.fetch('image')
#
#   user.image = params[:image]
#   #image[:tempfile]     = params[:image][:tempfile],
#   #image[:filename]     = params[:image][:filename],
#   #image[:content_type] = params[:image][:type],
#   #image[:size]         = params[:image][:tempfile].size
#   user.save
#   binding.pry
#
# end

patch '/users/:id/update' do
  id = params.fetch('id')
  user = User.find(id)

  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  email = params.fetch('email')
  phone = params.fetch('phone')
  username = params.fetch('username')
  address = params.fetch('address')
  city = params.fetch('city')
  state = params.fetch('state')
  zip = params.fetch('zip')

  user.update({ first_name: first_name, last_name: last_name, email: email, phone: phone, username: username, address: address, city: city, state: state, zip: zip })

  redirect "/users/#{id}"
end

get '/signup' do
  erb(:signup)
end

get '/jams/new' do
  @instruments = Instrument.all
  erb(:jams_create)
end

post '/jams/new' do
  address = params.fetch('address')
  city = params.fetch('city').capitalize
  state = params.fetch('state').upcase
  zip = params.fetch('zip').gsub(/([\D])/, "")
  host_id = params.fetch('host_id')
  date = params.fetch('date')
  time = params.fetch('time')

  instrument_id = params.fetch('instrument_id')

  @session = Session.create({:host_id => host_id, :address => address, :city => city, :state => state, :zip => zip, :date => date, :time => time})

  if @session.save
    instrument_id.each do |id|
      i = Instrument.find(id)
      @session.instruments.push(i)
    end
    redirect("/jams/#{@session.id}")
  else
    erb(:errors)
  end
end
#
# post '/jams/:id/instruments/new' do
#   binding.pry
#   if session[:jam] == nil
#     binding.pry
#     redirect('/jams/new')
#   end
#   instruments = params.fetch("instrument_id")
#   instruments.each do |instrument|
#     Session.find(session[:session_id].to_i).instruments << instrument
#   end
#   redirect("/jams/#{session[:session_id].to_i}")
# end

get '/jams/:id' do
  session[:jam] = nil
  @session = Session.find(params.fetch('id'))
  @instruments = @session.instruments()
  session[:user] = User.find(1)
  erb(:jam)
end



post '/signup' do
  session[:user] = nil
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
    session[:user] = @user
    erb(:profile)
  else
    erb(:errors)
  end
end

post '/users/signin' do
  username = params.fetch("username")
  password = params.fetch("password")
  @user = User.find_by(:username => username)

  if @user == nil
    erb :errors
  elsif @user.authenticate(password)
    session[:user] = @user
    redirect "/users/#{@user.id}"
  else
    erb(:errors)
  end
end

get '/signout' do
  session[:user] = nil
  redirect('/')
end

get '/jams' do
  @sessions = Session.all()
  erb(:jams_find)
end

get '/errors' do
  erb(:errors)
end
