require 'rubygems'
require 'sinatra'
require 'twitter_oauth'
require 'www/delicious'

# Del.icio.us Auth
delicious = WWW::Delicious.new('JulienXX', 'Jul*d3lic')

# # Twitter HTTP Auth
# httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
# twitter = Twitter::Base.new(httpauth)

before do
  # @oauth = OAuth::Consumer.new(
  #       'Ob88dhyY3G6F04NgHZrCA', 
  #       'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw', 
  #       {:site => 'http://twitter.com'}
  #     )
  
  @user = session[:user]
  @client = TwitterOAuth::Client.new(
    :consumer_key => 'Ob88dhyY3G6F04NgHZrCA',
    :consumer_secret => 'WbWsanzbO8WRcghMBSByIasp7Lyzg63huvYxTGDIw',
    :token => session[:access_token],
    :secret => session[:secret_token]
  )
  @rate_limit_status = @client.rate_limit_status
  
end

get '/' do
  # @results = Twitter::Search.new(' "ruby" ')
  #     @results.per_page(10)
  # 
  #     erb :index
  # @httpauth = Twitter::HTTPAuth.new('julienXX', 'Julien1980')
  #   @twitter = Twitter::Base.new(@httpauth)
  redirect '/timeline' if @user
  erb :index
end

get '/timeline' do
  
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



use_in_file_templates!

__END__

@@ index
<div id="connect_button">
    <a href="/connect"><img src="sign_in_with_twitter.gif"/></a>
</div>

@@ timeline
<h1>Favorites</h1>
<ul>
  <%= @client.public_timeline.each{ |tweet| puts tweet.inspect } %>
  
</ul>

