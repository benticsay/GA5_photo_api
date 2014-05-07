require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pg'
require 'pry'
require 'httparty'

# establishes connection once and for all...
ActiveRecord::Base.establish_connection({
  database: "photo_api",
  adapter: "postgresql"
})

# MODELS
require_relative 'models/selfie.rb'

get '/' do 
	@selfie = HTTParty.get("https://api.instagram.com/v1/tags/selfie/media/recent?client_id=53e2f4c98e2b4a29bd762a4e28351c0c")

	@selfie1 = @selfie["data"][0]["images"]["standard_resolution"]["url"]
	@selfie2 = @selfie["data"][4]["images"]["standard_resolution"]["url"]
	@selfie3 = @selfie["data"][8]["images"]["standard_resolution"]["url"]

	erb :index
end


# get '/index' do

# 	erb :index

# end

post '/selfies' do
  # processes new item data
  name = "selfie1"
  description = params[:kfm]
  url = @selfie1
  Selfie.create(
    user_name: name,
    description: description,
    url: url
  )

  name = "selfie2"
  description = params[:kfm]
  url = @selfie2
  Selfie.create(
    user_name: name,
    description: description,
    url: url
  ) 

  name = "selfie3"
  description = params[:kfm]
  url = @selfie3
  Selfie.create(
    user_name: name,
    description: description,
    url: url
  )
  redirect "/"
end