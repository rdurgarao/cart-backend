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

post '/login' do 
    @user_details = JSON.parse(request.body.read, symbolize_names: true)
    @user_files = File.read "./users.json"
    @user_files_json = JSON.parse @user_files

    @user = @user_files_json.select {|user| user['emailOrPhone'].eql?@user_details[:email]}.first

    if @user && @user['password'].eql?(@user_details[:password])
        {status: 'success', user: @user}.to_json
    else 
        {status: 'failure', message: 'Invalid credentials'}.to_json
    end
end