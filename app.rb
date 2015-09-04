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

end

before do
  cache_control :public, :no_cache
	cache_control :views, :no_cache
end

get '/' do
  erb(:index)
end

get '/users/:id' do
  if login?
    @user = User.find(params.fetch('id'))
    if session[:user].id == @user.id
      @profile_owner = true
    end
    erb(:profile)
  else
    redirect('/')
  end
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

post '/users/:id/image/edit' do
  tempfile = params['image'][:tempfile]
  filename = params['image'][:filename]
  id = params.fetch('id')
  user = User.find(id)

  file = FileUtils.copy(tempfile.path, "./public/img/avatar/#{filename}")
  user.update({image_url: "/img/avatar/#{filename}", image_file_name: "#{filename}", })
  redirect "/users/#{id}"
end

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

get '/jams/:id/edit' do
  @session = Session.find(params.fetch('id'))
  @instruments = Instrument.all
  erb(:jam_edit)
end

patch '/jams/:id/edit' do
  session_id = params.fetch("id")
  @session = Session.find(session_id)
  address = params.fetch('address')
  city = params.fetch('city').capitalize
  state = params.fetch('state').upcase
  zip = params.fetch('zip').gsub(/([\D])/, "")
  host_id = params.fetch('host_id')
  date = params.fetch('date')
  time = params.fetch('time')
  @session.update({:host_id => host_id, :address => address, :city => city, :state => state, :zip => zip, :date => date, :time => time})
  @session.instruments.destroy_all

  instrument_id = params.fetch('instrument_id')

  instrument_id.each do |id|
    i = Instrument.find(id)
    @session.instruments.push(i)
  end
  redirect("/jams/#{@session.id}")
end


get '/jams/:id' do
  session[:jam] = nil
  @session = Session.find(params.fetch('id'))
  @instruments = @session.instruments()
  erb(:jam)
end

post '/jams/:id/users/:user_id' do
  @session = Session.find(params.fetch('id'))
  @user = User.find(params.fetch('user_id'))
  @instrument = Instrument.find(params.fetch('instrument_id'))
  if @session.users.include?(@user)
    redirect("/jams/#{@session.id}")
  else
    @session.users << @user
    @session.instruments.delete(@instrument)
  end
  redirect("/jams/#{@session.id}")
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
    redirect "/users/#{@user.id}"
  else
    erb(:errors)
  end
end

post '/users/signin' do
  session[:user] = nil
  username = params.fetch("username")
  password = params.fetch("password")
  @user = User.find_by(:username => username)

  if @user == nil
    @incorrect_password == true
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
