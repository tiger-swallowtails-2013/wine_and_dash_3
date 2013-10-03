require 'sinatra'
require 'sinatra/activerecord'

require './user' 
require './winery' 
set :database, 'postgres://localhost/wineanddash'

enable :sessions

get '/' do
	erb :index
end

post '/' do

	username = params[:username]
	password = params[:password]
	user = User.where(username: username, password: password)
	p "user inspect:" + user.inspect

	if user = User.authenticate(username,password)
		session[:user] = user
		p session[:user].inspect
		redirect to('/home')
	else 
		redirect to('/')
	end
end

get '/home' do
	@user = session[:user]
	p @user.inspect
	erb :home
end

get '/:id' do
	if user = User.find(params[:id]) 
		puts "user email is #{user.email}" 
  else
  	"there is no user with id #{params[:id]}"
  end
end



