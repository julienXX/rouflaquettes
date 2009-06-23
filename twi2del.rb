#!/usr/bin/env ruby

### 
# A small script to copy your Twitter favorites links into Del.icio.us
# Replace Dusername, Dpassword, Tusername, Tpassword with your credentials.
###

require 'twitter'
require 'www/delicious'


# Del.icio.us Auth
delicious = WWW::Delicious.new('Dusername', 'Dpassword')

# Twitter HTTP Auth
httpauth = Twitter::HTTPAuth.new('Tusername', 'Tpassword')
twitter = Twitter::Base.new(httpauth)

twitter.favorites.each do |tweet|
  text = tweet.text
  link_regex = /(http:\S+)/    
  links = text.scan(link_regex)[0]
  content = text.gsub(link_regex, '')
  link = links[0]
  
  posts = delicious.posts_get(:url => link)
  
  if posts.empty?
    puts "Here is the tweet: " + content
    puts "Enter a title "
    title = gets
    puts "Enter tags: "
    tags = gets
  
    delicious.posts_add(:url => link, :title => title, :tags => tags, :notes => 'Imported from Twitter')
  end
end