require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pg'
require 'pry'
require 'httparty'

# establishes connection once and for all...
ActiveRecord::Base.establish_connection({
  database: "insta_kfm",
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


get '/show' do
	@selfies_show = Selfie.all
	erb :show

end

post '/selfies' do


  # processes new item data
  name = "selfie1"
  description_1 = params[:kfm_1]
  url = params[:url_1]
  Selfie.create(
    user_name: name,
    description: description_1,
    url: url
  )

  name = "selfie2"
  description_2 = params[:kfm_2]
  url = params[:url_2]
  Selfie.create(
    user_name: name,
    description: description_2,
    url: url
  ) 

  name = "selfie3"
  description_3 = params[:kfm_3]
  url = params[:url_3]
  Selfie.create(
    user_name: name,
    description: description_3,
    url: url
  )
  redirect "/"
end