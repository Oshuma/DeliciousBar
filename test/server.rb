require 'sinatra/base'

class TestServer < Sinatra::Application
  set :public, "#{File.dirname(__FILE__)}/response"

  get '/posts/all' do
    File.readlines("#{options.public}/posts_all.xml")
  end

  get '/tags/get' do
    File.readlines("#{options.public}/tags.xml")
  end
end

TestServer.run! if $0 == __FILE__
