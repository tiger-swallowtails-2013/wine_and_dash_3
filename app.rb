require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth-facebook'

require './user' 
require './winery' 
set :database, 'postgres://localhost/wineanddash'

enable :sessions

# class MyApplication < Sinatra::Base
#   use Rack::Session::Cookie
#   use OmniAuth::Strategies::Facebook
# end


# get '/auth/:facebook/callback' do
#   redirect to('/home')
# end

# class SessionsController < ApplicationController
#   def create
#     @user = User.find_or_create_from_auth_hash(auth_hash)
#     self.current_user = @user
#     redirect to('/')
#   end

#   protected

#   def auth_hash
#     request.env['omniauth.auth']
#   end
# end


get '/' do
	erb :index
	# redirect '/auth/facebook'
end


post '/' do

	username = params[:username]
	password = params[:password]
	user = User.where(username: username, password: password)
	p "user inspect:" + user.inspect

	if user = User.authenticate(username,password)
		session[:user] = user
		p session[:user].inspect
		redirect to('/winery_list')
	else 
		redirect to('/')
	end
end

get '/winery_list' do
	@winery_list = Winery.all
	erb :winery_list
end

get '/home' do
	@user = session[:user]
	p @user.inspect
	erb :home
end

get '/winemapper' do
	erb :winemapper
end

get '/:id' do
	if user = User.find(params[:id]) 
		puts "user email is #{user.email}" 
  else
  	"there is no user with id #{params[:id]}"
  end
end





