#!/usr/bin/env rubygems
require 'rubygems'
require 'sinatra'
require 'twitter_oauth'
require 'www/delicious'
require 'erb'

CONTENT_TYPES = {:html => 'text/html', :css => 'text/css', :js  => 'application/javascript'}

# Del.icio.us Auth
delicious = WWW::Delicious.new('julienTEST', 'mikros0')

configure do
  set :sessions, true
end

before do
  @user = session[:user]
  @client = TwitterOAuth::Client.new(
    :consumer_key => 'Ob88dhyY3G6F04NgHZrCA', #replace with your own consumer key
    :consumer_secret => 'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw', #replace with your own consumer secret
    :token => session[:access_token],
    :secret => session[:secret_token]
  )
  
  request_uri = case request.env['REQUEST_URI']
    when /\.css$/ : :css
    when /\.js$/  : :js
    else          :html
  end
  content_type CONTENT_TYPES[request_uri], :charset => 'utf-8'
  
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

post '/bookmark' do
  @ids = Array.new
  @i = 1
  @client.favorites.each do |tweet|
    if params["check_#{tweet['id']}"].to_i == 1
      @ids.push(@i.to_s + ',')
      @i = @i +1
      next
    else
      @ids.push("#{tweet['id']},\n")
    end
  end
  erb "id selected: <%= @ids %>"

  # link_regex = /(http:\S+)/    
  #   links = tweet['text'].scan(link_regex)[0]
  #   content = tweet['text'].gsub(link_regex, '')
  #           
  #delicious.posts_add(:url => links[0], :title => content, :notes => 'Imported from Twitter')
  
end

