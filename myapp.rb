require 'sinatra'
require 'json'

get '/' do
    'Hello world!'
end

get '/user' do
    data = { name: "tatsuya", twitter: "@Tatsuya_ss0121" }
    data.to_json
end

