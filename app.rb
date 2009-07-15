#!/usr/bin/env rubygems
require 'rubygems'
require 'sinatra'
require 'twitter_oauth'
require 'www/delicious'

# Del.icio.us Auth
<<<<<<< HEAD:app.rb
delicious = WWW::Delicious.new('username', 'password')
=======
delicious = WWW::Delicious.new('JulienXX', 'Jul*d3lic')

# # Twitter HTTP Auth
# httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
# twitter = Twitter::Base.new(httpauth)
>>>>>>> ac2ca5a036d16761eac90a7ccc771924c8d3a6f2:app.rb

configure do
  set :sessions, true
end

before do
<<<<<<< HEAD:app.rb
  @user = session[:user]
  @client = TwitterOAuth::Client.new(
    :consumer_key => 'Ob88dhyY3G6F04NgHZrCA', #replace with your own consumer key
    :consumer_secret => 'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw', #replace with your own consumer secret
=======
  # @oauth = OAuth::Consumer.new(
  #       'Ob88dhyY3G6F04NgHZrCA', 
  #       'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw', 
  #       {:site => 'http://twitter.com'}
  #     )
  
  @user = session[:user]
  @client = TwitterOAuth::Client.new(
    :consumer_key => 'Ob88dhyY3G6F04NgHZrCA',
    :consumer_secret => 'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw',
>>>>>>> ac2ca5a036d16761eac90a7ccc771924c8d3a6f2:app.rb
    :token => session[:access_token],
    :secret => session[:secret_token]
  )
  @rate_limit_status = @client.rate_limit_status
  @page = 1
  
end


get '/' do
  redirect '/timeline' if @user
  erb :index
end

get '/timeline' do
  @tweets = @client.favorites
  erb :timeline
end

get '/timeline/:page' do
  @page = params[:page]
  @tweets = @client.favorites(params[:page])
  erb :timeline
end

# store the request tokens and send to Twitter
get '/connect' do
  request_token = @client.request_token
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/auth' do
  # Exchange the request token for an access token.
  @access_token = @client.authorize(
    session[:request_token],
    session[:request_token_secret]
  )
  
  if @client.authorized?
      # Storing the access tokens so we don't have to go back to Twitter again
      # in this session.  In a larger app you would probably persist these details somewhere.
      session[:access_token] = @access_token.token
      session[:secret_token] = @access_token.secret
      session[:user] = true
      redirect '/timeline'
    else
      redirect '/'
  end
end

get '/disconnect' do
  session[:user] = nil
  session[:request_token] = nil
  session[:request_token_secret] = nil
  session[:access_token] = nil
  session[:secret_token] = nil
  redirect '/'
end

