require 'rubygems'
require 'sinatra'
require 'twitter'
require 'www/delicious'

# Del.icio.us Auth
delicious = WWW::Delicious.new('JulienXX', 'Jul*d3lic')

# # Twitter HTTP Auth
# httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
# twitter = Twitter::Base.new(httpauth)

before do
  @client = OAuth::Consumer.new(
    'consumer token', 
    'consumer secret', 
    {:site => 'http://twitter.com'}
  )
end

get '/' do
  # @results = Twitter::Search.new(' "ruby" ')
  #     @results.per_page(10)
  # 
  #     erb :index
  # @httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
  #   @twitter = Twitter::Base.new(@httpauth)
  erb :index
end

get '/fav' do
  erb :show
end

# store the request tokens and send to Twitter
get '/connect' do
  request_token = @client.get_request_token
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url.gsub('authorize', 'authenticate') 
end

use_in_file_templates!

__END__

@@index
<div id="connect_button">
    <a href="/connect"><img src="sign_in_with_twitter.gif"/></a>
</div>

@@ show
<html>
  <head>
  </head>
 
  <body>
    <h1>Favorites</h1>
    <ul>
      <% @twitter.favorites(:page => 2).each do |tweet| %>
        <li><%= tweet.text %></li>
      <% end %>
    </ul>
  </body>
</html>

