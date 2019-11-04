require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative "cookbook"
require_relative "recipe"

get '/' do
  # "<h1>Hello <em>world</em>!</h1> for instance"
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/about' do
  erb :about
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new(params[:name], params[:description], params[:prep_time])
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect to '/'
end

# get '/' do  # <- Router part

  # [...]   #
  # [...]   # <- Controller part
  # [...]   #

# end
