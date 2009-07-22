#!/usr/bin/env rubygems
require 'rubygems'
require 'sinatra'
require 'twitter'
require 'www/delicious'
require 'erb'

CONTENT_TYPES = {:html => 'text/html', :css => 'text/css', :js  => 'application/javascript'}

# Del.icio.us Auth
delicious = WWW::Delicious.new('julienTEST', 'mikros0')

configure do
  set :sessions, true
end

before do
  @httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
  @client = Twitter::Base.new(@httpauth)
  
  @page = 1
end

get '/' do
  redirect '/timeline'
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

post '/bookmark' do
  @ids = Array.new
  @client.favorites.each do |tweet|
  if params[:"#{tweet['id']}"] != 0
    @ids.push('toto')
  else
    @ids.push("#{tweet['id']}")
  end
  erb "selected <%= @ids %>"
end
end
