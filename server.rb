# server.rb
require 'sinatra'
require 'json'

@@cart = []

configure do
    enable :cross_origin
end

before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    content_type :json
end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

get '/products' do
    file = File.open "./products.json"
    data = JSON.load file

    return data.to_json
end

post '/cart' do 
    @@cart = JSON.parse request.body.read

    return @@cart.to_json
end

get '/cart' do 
    @@cart.to_json
end